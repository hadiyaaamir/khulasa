import 'package:khulasa/Models/source.dart';

List<Source> sources = [
  Source(
    source: 'Dawn News',
    titleTag: 'story__link',
    contentTag: 'story__content',
    dateTag: 'story__time text-4',
    isDateTime: false,
    webLink: "https://www.dawnnews.tv/",
    rssSummaryRatio: 0.1,
  ),
  // Source(
  //   source: 'ARY News',
  //   titleTag: 'tdb-title-text',
  //   contentTag: 'p',
  //   dateTag: 'time',
  //   dateTagType: 'attribute-tag',
  //   webLink: "https://urdu.arynews.tv/",
  //   rssSummaryRatio: 0.2,
  //   attributeName: 'datetime',
  // ),
  Source(
    source: 'Jang',
    titleTag: 'h1',
    titleTagType: 'tag',
    contentTag: 'detail_view_content',
    contentTagType: 'paragraph',
    dateTag: 'detail-time',
    dateIndex: 2,
    isDateTime: false,
    webLink: "https://jang.com.pk/",
    rssSummaryRatio: 0.1,
  ),
  Source(
    source: 'Express News',
    titleTag: 'title',
    contentTag: 'p',
    contentTagType: 'paragraph',
    dateTag: 'timestamp',
    dateTagType: 'attribute-class',
    isDateTime: false,
    attributeName: 'title',
    webLink: 'https://www.express.pk/',
    rssSummaryRatio: 0.1,
  ),
  // Source(
  //   source: 'Nawaiwaqt',
  //   titleTag: 'h2',
  //   titleTagType: 'tag',
  //   contentTag: 'entry-post mrgn-top',
  //   dateTag: 'time',
  //   isDateTime: false,
  //   webLink: 'https://www.nawaiwaqt.com.pk/home',
  //   rssSummaryRatio: 0.3,
  // ),
  Source(
    source: 'Jasarat',
    titleTag: 'entry-title',
    contentTag: 'p',
    contentTagType: 'paragraph',
    dateTag: 'time',
    dateTagType: 'attribute-tag',
    attributeName: 'datetime',
    webLink: 'https://www.jasarat.com/',
    rssSummaryRatio: 0.2,
  ),
  Source(
    source: 'BBC Urdu',
    titleTag: 'bbc-1gvq3vt e1p3vdyi0',
    contentTag: 'p',
    contentTagType: 'paragraph',
    dateTag: 'time',
    dateTagType: 'attribute-tag',
    attributeName: 'datetime',
    webLink: 'https://www.bbc.com/urdu',
    rssSummaryRatio: 0.05,
  ),
];
