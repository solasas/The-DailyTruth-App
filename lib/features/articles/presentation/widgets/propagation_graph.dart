import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../domain/entities/origin.dart';

enum _Lane { origin, spreading, checking, mentions }

extension on _Lane {
  String get label => switch (this) {
    _Lane.origin => 'Origin',
    _Lane.spreading => 'Spreading',
    _Lane.checking => 'Checking',
    _Lane.mentions => 'Mentions',
  };
}

class _Point {
  _Point({
    required this.lane,
    required this.day,
    required this.title,
    required this.detail,
    this.entry,
  });

  final _Lane lane;
  final DateTime day;
  final String title;
  final String detail;
  final TimelineEntry? entry;

  double x = 0;
  double y = 0;
}

/// How a claim spread over time: dates on x, one lane per role.
///
/// The data has dates, not copy relationships, so the graph never implies
/// who copied whom — lines only join each source to the first known
/// appearance.
class PropagationGraph extends StatefulWidget {
  const PropagationGraph({super.key, required this.origin});

  final Origin origin;

  /// `true` when [origin] has enough dated points to draw anything.
  static bool canDraw(Origin origin) => _build(origin).points.length >= 2;

  @override
  State<PropagationGraph> createState() => _PropagationGraphState();
}

class _Built {
  _Built(this.points, this.anchor, this.undated);
  final List<_Point> points;
  final _Point? anchor;
  final int undated;
}

_Lane _laneOf(String kind) => switch (kind) {
  'repeats' => _Lane.spreading,
  'debunks' || 'fact_check' => _Lane.checking,
  _ => _Lane.mentions,
};

_Built _build(Origin origin) {
  final points = <_Point>[];
  _Point? originPoint;

  final claimDay = origin.claimDate == null || origin.claimDate!.length < 10
      ? null
      : DateTime.tryParse('${origin.claimDate!.substring(0, 10)}T00:00:00Z');
  if (origin.hasClaimant && claimDay != null) {
    originPoint = _Point(
      lane: _Lane.origin,
      day: claimDay,
      title: origin.claimant!.trim(),
      detail: [
        origin.claimDate!,
        if ((origin.claimantSource ?? '').isNotEmpty)
          'per ${origin.claimantSource}',
      ].join(' · '),
    );
    points.add(originPoint);
  }

  var undated = 0;
  for (final e in origin.timeline) {
    final day = e.day;
    if (day == null) {
      undated++;
      continue;
    }
    points.add(
      _Point(
        lane: _laneOf(e.kind),
        day: day,
        title: e.domain,
        detail: [
          e.date,
          _stanceText(e),
          'trust ${e.trust.toStringAsFixed(2)}',
          if (e.isWiderSearch) 'wider search',
        ].join(' · '),
        entry: e,
      ),
    );
  }

  _Point? anchor = originPoint;
  if (anchor == null) {
    for (final p in points) {
      if (p.lane != _Lane.spreading) continue;
      if (anchor == null || p.day.isBefore(anchor.day)) anchor = p;
    }
  }
  return _Built(points, anchor, undated);
}

String _stanceText(TimelineEntry e) => switch (e.kind) {
  'repeats' => 'repeats claim',
  'debunks' => 'contradicts claim',
  'fact_check' => 'fact-check: ${e.label.isEmpty ? 'reviewed' : e.label}',
  _ => 'mentions claim',
};

class _PropagationGraphState extends State<PropagationGraph> {
  static const _labelWidth = 78.0;
  static const _laneHeight = 54.0;
  static const _axisHeight = 30.0;
  static const _fan = 11.0;

  _Point? _selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dark = theme.brightness == Brightness.dark;
    final built = _build(widget.origin);
    if (built.points.length < 2) return const SizedBox.shrink();

    final lanes = _Lane.values
        .where((l) => built.points.any((p) => p.lane == l))
        .toList();
    final height = lanes.length * _laneHeight + _axisHeight;

    final days = built.points.map((p) => p.day).toList()..sort();
    final first = days.first;
    final last = days.last;

    final caption = StringBuffer(
      built.anchor != null
          ? 'Lines join each source to the first known appearance. They show '
                'order in time, not who copied whom.'
          : 'No dated source spreading the claim was found, so there is no '
                'starting point to draw from.',
    );
    if (built.undated > 0) {
      caption.write(
        ' ${built.undated} undated '
        '${built.undated == 1 ? 'source is' : 'sources are'} listed below '
        'but not plotted.',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final plotLeft = _labelWidth + 12;
            final plotRight = width - 14;
            final span = last.difference(first).inHours.toDouble();

            // Position every point.
            final perCell = <String, int>{};
            for (final p in built.points) {
              p.x = span == 0
                  ? (plotLeft + plotRight) / 2
                  : plotLeft +
                        (plotRight - plotLeft) *
                            (p.day.difference(first).inHours / span);
              final cell = '${p.lane.index}|${p.day.millisecondsSinceEpoch}';
              final n = perCell[cell] = (perCell[cell] ?? 0) + 1;
              final inCell = built.points
                  .where(
                    (q) =>
                        q.lane == p.lane &&
                        q.day.millisecondsSinceEpoch ==
                            p.day.millisecondsSinceEpoch,
                  )
                  .length;
              final laneIndex = lanes.indexOf(p.lane);
              p.y =
                  laneIndex * _laneHeight +
                  _laneHeight / 2 +
                  (n - 1 - (inCell - 1) / 2) * _fan;
            }

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: (d) {
                _Point? best;
                var bestDist = 22.0;
                for (final p in built.points) {
                  final dist = (Offset(p.x, p.y) - d.localPosition).distance;
                  if (dist < bestDist) {
                    best = p;
                    bestDist = dist;
                  }
                }
                setState(() => _selected = best == _selected ? null : best);
              },
              child: Semantics(
                label:
                    'Propagation graph with ${built.points.length} dated '
                    'sources from ${DateFormat.yMMMd().format(first)} to '
                    '${DateFormat.yMMMd().format(last)}',
                child: CustomPaint(
                  size: Size(width, height),
                  painter: _GraphPainter(
                    points: built.points,
                    anchor: built.anchor,
                    lanes: lanes,
                    selected: _selected,
                    first: first,
                    last: last,
                    plotLeft: plotLeft,
                    plotRight: plotRight,
                    laneHeight: _laneHeight,
                    axisTop: lanes.length * _laneHeight,
                    dark: dark,
                    text: theme.colorScheme.onSurface,
                    muted: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    hairline: theme.dividerColor,
                    card: theme.cardColor,
                    labelStyle:
                        theme.textTheme.labelSmall ??
                        const TextStyle(fontSize: 11),
                  ),
                ),
              ),
            );
          },
        ),
        if (_selected != null) ...[
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _selected!.title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(_selected!.detail, style: theme.textTheme.bodySmall),
              ],
            ),
          ),
        ],
        const SizedBox(height: 8),
        Text(caption.toString(), style: theme.textTheme.bodySmall),
      ],
    );
  }
}

class _GraphPainter extends CustomPainter {
  _GraphPainter({
    required this.points,
    required this.anchor,
    required this.lanes,
    required this.selected,
    required this.first,
    required this.last,
    required this.plotLeft,
    required this.plotRight,
    required this.laneHeight,
    required this.axisTop,
    required this.dark,
    required this.text,
    required this.muted,
    required this.hairline,
    required this.card,
    required this.labelStyle,
  });

  final List<_Point> points;
  final _Point? anchor;
  final List<_Lane> lanes;
  final _Point? selected;
  final DateTime first, last;
  final double plotLeft, plotRight, laneHeight, axisTop;
  final bool dark;
  final Color text, muted, hairline, card;
  final TextStyle labelStyle;

  // Red/green pair checked for colour-blind readers in both themes; shape
  // and lane carry the meaning too, so it never rests on colour alone.
  Color get _spreading =>
      dark ? const Color(0xFFE10600) : const Color(0xFFC1121F);
  Color get _checking =>
      dark ? const Color(0xFF2AAE5C) : const Color(0xFF16A34A);

  Color _laneColor(_Lane l) => switch (l) {
    _Lane.origin => text,
    _Lane.spreading => _spreading,
    _Lane.checking => _checking,
    _Lane.mentions => Colors.grey,
  };

  @override
  void paint(Canvas canvas, Size size) {
    final line = Paint()
      ..color = hairline
      ..strokeWidth = 1;

    // Lane labels + faint lane guides.
    for (var i = 0; i < lanes.length; i++) {
      final cy = i * laneHeight + laneHeight / 2;
      canvas.drawLine(Offset(plotLeft, cy), Offset(plotRight, cy), line);
      _text(
        canvas,
        lanes[i].label,
        Offset(0, cy),
        labelStyle.copyWith(color: muted),
        maxWidth: plotLeft - 8,
        centerY: true,
      );
    }

    // Links: anchor → every later point, in the target's lane colour.
    if (anchor != null) {
      for (final p in points) {
        if (identical(p, anchor) || p.day.isBefore(anchor!.day)) continue;
        final paint = Paint()
          ..color = _laneColor(p.lane).withValues(alpha: 0.45)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.25;
        final a = Offset(anchor!.x, anchor!.y);
        final b = Offset(p.x, p.y);
        final mid = (a.dx + b.dx) / 2;
        canvas.drawPath(
          Path()
            ..moveTo(a.dx, a.dy)
            ..cubicTo(mid, a.dy, mid, b.dy, b.dx, b.dy),
          paint,
        );
      }
    }

    // Axis.
    canvas.drawLine(
      Offset(plotLeft, axisTop + 4),
      Offset(plotRight, axisTop + 4),
      line,
    );
    final spanDays = last.difference(first).inDays;
    final fmt = spanDays > 730
        ? DateFormat.y()
        : spanDays > 60
        ? DateFormat.yMMM()
        : DateFormat.MMMd();
    final ticks = spanDays == 0
        ? 1
        : math.min(5, math.max(3, (plotRight - plotLeft) ~/ 90));
    for (var i = 0; i < ticks; i++) {
      final t = ticks == 1 ? 0.5 : i / (ticks - 1);
      final x = plotLeft + (plotRight - plotLeft) * t;
      final day = ticks == 1
          ? first
          : first.add(Duration(hours: (last.difference(first).inHours * t).round()));
      canvas.drawLine(Offset(x, axisTop + 4), Offset(x, axisTop + 9), line);
      _text(
        canvas,
        fmt.format(day),
        Offset(x, axisTop + 12),
        labelStyle.copyWith(color: muted),
        align: ticks == 1
            ? TextAlign.center
            : (i == 0
                  ? TextAlign.left
                  : (i == ticks - 1 ? TextAlign.right : TextAlign.center)),
      );
    }

    // Markers on top.
    for (final p in points) {
      _marker(canvas, p);
    }
  }

  void _marker(Canvas canvas, _Point p) {
    final c = Offset(p.x, p.y);
    final color = _laneColor(p.lane);
    // 2px ring in the card colour keeps overlapping markers separable.
    final ring = Paint()..color = card;
    final isSel = identical(p, selected);

    switch (p.lane) {
      case _Lane.origin:
        canvas.drawCircle(c, 7 + 2, ring);
        canvas.drawCircle(
          c,
          7 - 1,
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 2,
        );
      case _Lane.spreading:
        canvas.drawCircle(c, 6 + 2, ring);
        canvas.drawCircle(c, 6, Paint()..color = color);
      case _Lane.checking:
        final r = 5.0;
        Path diamond(double r) => Path()
          ..moveTo(c.dx, c.dy - r)
          ..lineTo(c.dx + r, c.dy)
          ..lineTo(c.dx, c.dy + r)
          ..lineTo(c.dx - r, c.dy)
          ..close();
        canvas.drawPath(
          diamond(r + 3),
          ring,
        );
        canvas.drawPath(diamond(r), Paint()..color = color);
      case _Lane.mentions:
        canvas.drawCircle(c, 6 + 2, ring);
        canvas.drawCircle(
          c,
          5,
          Paint()
            ..color = color
            ..style = PaintingStyle.stroke
            ..strokeWidth = 1.75,
        );
    }

    if (isSel) {
      canvas.drawCircle(
        c,
        12,
        Paint()
          ..color = text.withValues(alpha: 0.5)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
  }

  void _text(
    Canvas canvas,
    String s,
    Offset at,
    TextStyle style, {
    double maxWidth = 80,
    bool centerY = false,
    TextAlign align = TextAlign.left,
  }) {
    final tp = TextPainter(
      text: TextSpan(text: s, style: style),
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '…',
    )..layout(maxWidth: maxWidth);
    var dx = at.dx;
    if (align == TextAlign.center) dx -= tp.width / 2;
    if (align == TextAlign.right) dx -= tp.width;
    tp.paint(canvas, Offset(dx, centerY ? at.dy - tp.height / 2 : at.dy));
  }

  @override
  bool shouldRepaint(_GraphPainter old) =>
      old.selected != selected ||
      old.points != points ||
      old.dark != dark ||
      old.plotRight != plotRight;
}
