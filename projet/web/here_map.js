function initializeHereMap(apiKey, apiId, lat, lng) {
  var platform = new H.service.Platform({
    '6nIGuVmqqMwOppHrpBSBf6U_muWT0r2bNBbONkEBilM': apiKey,
    'tL1Jw29y9wLiIatb5yIG': apiId
  });

  var defaultLayers = platform.createDefaultLayers();

  var map = new H.Map(
    document.getElementById('mapContainer'),
    defaultLayers.vector.normal.map,
    {
      zoom: 10,
      center: { lat: lat, lng: lng }
    }
  );

  var ui = H.ui.UI.createDefault(map, defaultLayers);
}
