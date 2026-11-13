/// Origin-trail entities (`Origin`, `TimelineEntry`, `EvidenceMeta` on the
/// wire). Report-only: they never change a verdict, and the trail is the
/// *earliest source found*, not proof of origin.
library;

/// One source in an origin timeline.
class TimelineEntry {
  const TimelineEntry({
    required this.date,
    required this.domain,
    required this.url,
    required this.kind,
    required this.label,
    required this.trust,
    required this.foundBy,
  });

  /// `YYYY-MM-DD`, or `''` when the source gave no date.
  final String date;
  final String domain;
  final String url;

  /// `repeats` | `debunks` | `fact_check` | `mentions`.
  final String kind;

  /// For `fact_check`: the rating (`False`), or `reviewed`.
  final String label;
  final double trust;

  /// `evidence` | `wider_search` | `fact_check`.
  final String foundBy;

  bool get isDated => date.isNotEmpty;
  bool get isWiderSearch => foundBy == 'wider_search';

  /// Parsed as UTC midnight so ordering never depends on the device zone.
  DateTime? get day =>
      isDated ? DateTime.tryParse('${date.substring(0, 10)}T00:00:00Z') : null;
}

/// A matched fact-check (Google Fact Check Tools).
class FactCheck {
  const FactCheck({
    required this.claimText,
    required this.claimant,
    required this.claimDate,
    required this.publisher,
    required this.site,
    required this.url,
    required this.rating,
    required this.ratingClass,
    required this.reviewDate,
    required this.relevance,
    required this.trust,
  });

  final String claimText, claimant, claimDate, publisher, site, url, rating;

  /// `false` | `misleading` | `true` | `other`.
  final String ratingClass;
  final String reviewDate;
  final double relevance, trust;
}

/// Who made a claim and where it was seen, oldest first.
class Origin {
  const Origin({
    required this.basis,
    this.claimant,
    this.claimDate,
    this.claimantSource,
    this.earliestSeen,
    this.firstDebunk,
    this.timeline = const [],
    this.factChecks = const [],
    this.factCheckStatus = 'skipped',
    this.searchStatus = 'skipped',
  });

  /// `fact_check` | `earliest_indexed` | `none`.
  final String basis;
  final String? claimant;

  /// `YYYY-MM-DD`.
  final String? claimDate;
  final String? claimantSource;
  final TimelineEntry? earliestSeen;
  final TimelineEntry? firstDebunk;
  final List<TimelineEntry> timeline;
  final List<FactCheck> factChecks;
  final String factCheckStatus;
  final String searchStatus;

  bool get hasClaimant => (claimant ?? '').trim().isNotEmpty;
}

/// Where one evidence snippet came from and what it says about the claim.
class EvidenceMeta {
  const EvidenceMeta({
    this.url = '',
    this.domain = '',
    this.provider = '',
    this.publishedAt = '',
    this.trust = 0.5,
    this.stance = 'neutral',
    this.stanceScore = 0,
  });

  final String url, domain, provider, publishedAt;
  final double trust;

  /// `repeats` | `debunks` | `neutral`.
  final String stance;
  final double stanceScore;
}
