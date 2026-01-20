# GEO Fundamentals

> Location và maps cho web applications

## Geolocation API

```typescript
navigator.geolocation.getCurrentPosition(
  (position) => {
    const { latitude, longitude } = position.coords;
    console.log(`Location: ${latitude}, ${longitude}`);
  },
  (error) => console.error(error),
  { enableHighAccuracy: true }
);
```

## Maps Libraries

### Leaflet (Open source)
```typescript
import L from 'leaflet';

const map = L.map('map').setView([10.762, 106.660], 13);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png').addTo(map);
L.marker([10.762, 106.660]).addTo(map);
```

### Google Maps
```typescript
new google.maps.Map(document.getElementById('map'), {
  center: { lat: 10.762, lng: 106.660 },
  zoom: 13
});
```

## Common Features

- Markers
- Polygons  
- Clustering
- Geocoding (address ↔ coordinates)
- Directions/routing
