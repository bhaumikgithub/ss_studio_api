var $lg = $('.light-gallery');
$lg.lightGallery({
  thumbnail: false,
  selector: 'a',
  mode: 'lg-fade',
  download: false,
  autoplayControls: false,
  zoom: false,
  fullScreen: false,
  videoMaxWidth: '1000px',
  loop: false,
  hash: true,
  mousewheel: true,
  videojs: true,
  share: false
});
var $cubegrid = $('#cube-grid');
$cubegrid.cubeportfolio({
  filters: '#cube-grid-filter',
  loadMore: '#cube-grid-more',
  loadMoreAction: 'click',
  layoutMode: 'grid',
  mediaQueries: [{width: 1440, cols: 3}, {width: 1024, cols: 3}, {width: 768, cols: 3}, {width: 575, cols: 2}, {width: 480, cols: 1}],
  defaultFilter: '*',
  animationType: 'quicksand',
  gapHorizontal: 15,
  gapVertical: 15,
  gridAdjustment: 'responsive',
  caption: 'fadeIn',
  displayType: 'bottomToTop',
  displayTypeSpeed: 100,
  plugins: {
    loadMore: {
      loadItems: 4
    }
  }
});
$cubegrid.on('onAfterLoadMore.cbp', function(event, newItemsAddedToGrid) {
  $('.cbp-item-load-more .overlay > a, .cbp-item-load-more .overlay > span').prepend('<span class="bg"></span>');
  // first destroy the gallery
  $lg.data('lightGallery').destroy(true);
  // reinit the gallery
  $lg.lightGallery({
    thumbnail: false,
    selector: 'a',
    mode: 'lg-fade',
    download: false,
    autoplayControls: false,
    zoom: false,
    fullScreen: false,
    videoMaxWidth: '1000px',
    loop: false,
    hash: true,
    mousewheel: true,
    videojs: true,
    share: false
  });
});
var $cubegridlarge = $('#cube-grid-large');
$cubegridlarge.cubeportfolio({
  filters: '#cube-grid-large-filter',
  loadMore: '#cube-grid-large-more',
  loadMoreAction: 'click',
  layoutMode: 'grid',
  mediaQueries: [{width: 1440, cols: 2}, {width: 1024, cols: 2}, {width: 768, cols: 2}, {width: 575, cols: 2}, {width: 320, cols: 1}],
  defaultFilter: '*',
  animationType: 'quicksand',
  gapHorizontal: 20,
  gapVertical: 20,
  gridAdjustment: 'responsive',
  caption: 'fadeIn',
  displayType: 'bottomToTop',
  displayTypeSpeed: 100,
  plugins: {
    loadMore: {
      loadItems: 4
    }
  }
});
$cubegridlarge.on('onAfterLoadMore.cbp', function(event, newItemsAddedToGrid) {
    // first destroy the gallery
  $lg.data('lightGallery').destroy(true);
  // reinit the gallery
  $lg.lightGallery({
    thumbnail: false,
    selector: 'a',
    mode: 'lg-fade',
    download: false,
    autoplayControls: false,
    zoom: false,
    fullScreen: false,
    videoMaxWidth: '1000px',
    loop: false,
    hash: true,
    mousewheel: true,
    videojs: true,
    share: false
  });
  $('.cbp-item-load-more .overlay > a, .cbp-item-load-more .overlay > span').prepend('<span class="bg"></span>');
});
var $cubegridfull = $('#cube-grid-full');
$cubegridfull.cubeportfolio({
  filters: '#cube-grid-full-filter',
  loadMore: '#cube-grid-full-more',
  loadMoreAction: 'click',
  layoutMode: 'masonry',
  mediaQueries: [{width: 1440, cols: 3}, {width: 1024, cols: 3}, {width: 768, cols: 2}, {width: 480, cols: 1}, {width: 320, cols: 1}],
  defaultFilter: '*',
  animationType: 'quicksand',
  gapHorizontal: 0,
  gapVertical: 0,
  gridAdjustment: 'responsive',
  caption: 'fadeIn',
  displayType: 'bottomToTop',
  displayTypeSpeed: 100,
  plugins: {
    loadMore: {
      loadItems: 4
    }
  }
});
$cubegridfull.on('onAfterLoadMore.cbp', function(event, newItemsAddedToGrid) {
  $('.cbp-item-load-more .overlay > a, .cbp-item-load-more .overlay > span').prepend('<span class="bg"></span>');
  // first destroy the gallery
  $lg.data('lightGallery').destroy(true);
  // reinit the gallery
  $lg.lightGallery({
    thumbnail: false,
    selector: 'a',
    mode: 'lg-fade',
    download: false,
    autoplayControls: false,
    zoom: false,
    fullScreen: false,
    videoMaxWidth: '1000px',
    loop: false,
    hash: true,
    mousewheel: true,
    videojs: true,
    share: false
  });
});
var $cubegridfulllarge = $('#cube-grid-full-large');
$cubegridfulllarge.cubeportfolio({
  filters: '#cube-grid-full-large-filter',
  loadMore: '#cube-grid-full-large-more',
  loadMoreAction: 'click',
  layoutMode: 'masonry',
  mediaQueries: [{width: 1440, cols: 3}, {width: 980, cols: 3}, {width: 720, cols: 2}, {width: 480, cols: 1}, {width: 320, cols: 1}],
  defaultFilter: '*',
  animationType: 'quicksand',
  gapHorizontal: 15,
  gapVertical: 15,
  gridAdjustment: 'responsive',
  caption: 'fadeIn',
  displayType: 'bottomToTop',
  displayTypeSpeed: 100,
  plugins: {
    loadMore: {
      loadItems: 4
    }
  }
});
$cubegridfulllarge.on('onAfterLoadMore.cbp', function(event, newItemsAddedToGrid) {
  $('.cbp-item-load-more .overlay > a, .cbp-item-load-more .overlay > span').prepend('<span class="bg"></span>');
  // first destroy the gallery
  $lg.data('lightGallery').destroy(true);
  // reinit the gallery
  $lg.lightGallery({
    thumbnail: false,
    selector: 'a',
    mode: 'lg-fade',
    download: false,
    autoplayControls: false,
    zoom: false,
    fullScreen: false,
    videoMaxWidth: '1000px',
    loop: false,
    hash: true,
    mousewheel: true,
    videojs: true,
    share: false
  });
});
var $cubemosaic = $('#cube-grid-mosaic');
$cubemosaic.cubeportfolio({
  filters: '#cube-grid-mosaic-filter',
  loadMore: '#cube-grid-mosaic-more',
  loadMoreAction: 'click',
  layoutMode: 'mosaic',
  mediaQueries: [{width: 1440, cols: 4}, {width: 1024, cols: 4}, {width: 768, cols: 3}, {width: 575, cols: 2}, {width: 320, cols: 1}],
  defaultFilter: '*',
  animationType: 'quicksand',
  gapHorizontal: 0,
  gapVertical: 0,
  gridAdjustment: 'responsive',
  caption: 'fadeIn',
  displayType: 'bottomToTop',
  displayTypeSpeed: 100,
  plugins: {
    loadMore: {
      loadItems: 4
    }
  }
});
$cubemosaic.on('onAfterLoadMore.cbp', function(event, newItemsAddedToGrid) {
  $('.cbp-item-load-more .overlay > a, .cbp-item-load-more .overlay > span').prepend('<span class="bg"></span>');
  // first destroy the gallery
  $lg.data('lightGallery').destroy(true);
  // reinit the gallery
  $lg.lightGallery({
    thumbnail: false,
    selector: 'a',
    mode: 'lg-fade',
    download: false,
    autoplayControls: false,
    zoom: false,
    fullScreen: false,
    videoMaxWidth: '1000px',
    loop: false,
    hash: true,
    mousewheel: true,
    videojs: true,
    share: false
  });
});
var $cubegrid2 = $('#cube-grid2');
$cubegrid2.cubeportfolio({
  filters: '#cube-grid2-filter',
  loadMore: '#cube-grid2-more',
  loadMoreAction: 'click',
  layoutMode: 'grid',
  mediaQueries: [{width: 1440, cols: 3}, {width: 1024, cols: 3}, {width: 768, cols: 3}, {width: 575, cols: 2}, {width: 320, cols: 1}],
  defaultFilter: '*',
  animationType: 'quicksand',
  gapHorizontal: 45,
  gapVertical: 15,
  gridAdjustment: 'responsive',
  caption: 'fadeIn',
  displayType: 'bottomToTop',
  displayTypeSpeed: 100,
  plugins: {
    loadMore: {
      loadItems: 4
    }
  }
});
$cubegrid2.on('onAfterLoadMore.cbp', function(event, newItemsAddedToGrid) {
  $('.cbp-item-load-more .overlay > a, .cbp-item-load-more .overlay > span').prepend('<span class="bg"></span>');
  // first destroy the gallery
  $lg.data('lightGallery').destroy(true);
  // reinit the gallery
  $lg.lightGallery({
    thumbnail: false,
    selector: 'a',
    mode: 'lg-fade',
    download: false,
    autoplayControls: false,
    zoom: false,
    fullScreen: false,
    videoMaxWidth: '1000px',
    loop: false,
    hash: true,
    mousewheel: true,
    videojs: true,
    share: false
  });
});
var $cubegridlarge2 = $('#cube-grid-large2');
$cubegridlarge2.cubeportfolio({
  filters: '#cube-grid-large2-filter',
  loadMore: '#cube-grid-large2-more',
  loadMoreAction: 'click',
  layoutMode: 'grid',
  mediaQueries: [{width: 1440, cols: 2}, {width: 1024, cols: 2}, {width: 768, cols: 2}, {width: 575, cols: 2}, {width: 320, cols: 1}],
  defaultFilter: '*',
  animationType: 'quicksand',
  gapHorizontal: 55,
  gapVertical: 20,
  gridAdjustment: 'responsive',
  caption: 'fadeIn',
  displayType: 'bottomToTop',
  displayTypeSpeed: 100,
  plugins: {
    loadMore: {
      loadItems: 4
    }
  }
});
$cubegridlarge2.on('onAfterLoadMore.cbp', function(event, newItemsAddedToGrid) {
  // first destroy the gallery
  $lg.data('lightGallery').destroy(true);
  // reinit the gallery
  $lg.lightGallery({
    thumbnail: false,
    selector: 'a',
    mode: 'lg-fade',
    download: false,
    autoplayControls: false,
    zoom: false,
    fullScreen: false,
    videoMaxWidth: '1000px',
    loop: false,
    hash: true,
    mousewheel: true,
    videojs: true,
    share: false
  });
  $('.cbp-item-load-more .overlay > a, .cbp-item-load-more .overlay > span').prepend('<span class="bg"></span>');
});
collage();
function collage() {
  $('#collage-large').removeWhitespace().collagePlus({
    'fadeSpeed': 5000,
    'targetHeight': 450,
    'direction': 'vertical',
    'allowPartialLastRow': true
  });
  $('#collage-medium').removeWhitespace().collagePlus({
    'fadeSpeed': 5000,
    'targetHeight': 350,
    'direction': 'vertical',
    'allowPartialLastRow': true
  });
};
var resizeTimer = null;
$(window).on('resize', function() {
  $('.collage .collage-image-wrapper').css("opacity", 0);
  if (resizeTimer) clearTimeout(resizeTimer);
  resizeTimer = setTimeout(collage, 200);
});