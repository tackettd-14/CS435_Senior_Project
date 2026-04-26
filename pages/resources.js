// Category config

const cat_colors = {
    "food pantry": "lightgreen",
    "hot meal service": "orange",
    "clothing closet":  "slateblue"
};

const cat_labels = {
    "food pantry": "food",
    "hot meal service": "meal",
    "clothing closet": "clothing"
};

// Map state
let resources = [];
let activeFilter = "all";
let markers = {};

/* Map */

// Zoom config
const config = {
    minZoom: 7,
    maxZoom: 18,
};

// Magnification with which the map will start
const zoom = 10;
const lat = 41.97787;
const lng = -91.66562;

const map = L.map("map", config).setView([lat, lng], zoom);

// Used to load and display tile layers on the map
L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution:
    '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map)
        