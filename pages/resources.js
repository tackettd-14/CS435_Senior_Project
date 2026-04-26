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
let RESOURCES = [];
let activeFilter = "all";
let markers = {};
let map;

// Map

// Zoom config
const config = {
    minZoom: 7,
    maxZoom: 18,
};

// Magnification with which the map will start
const zoom = 10;
const lat = 41.97787;
const lng = -91.66562;

map = L.map("map", config).setView([lat, lng], zoom);

// Used to load and display tile layers on the map
L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution:
    '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);

function placeMarkers() {

}

function applyFilters() {

}

// Fetch resources from PHP file
async function loadResources() {
    const loadmsg = document.getElementById("searchResults");
    loadmsg.innerHTML = '<div class="loadingMSG">Loading resources...</div>';

    try {
        const res = await fetch("get_resources.php");
        if(!res.ok) throw new Error(`HTTP ${res.status}`);
        RESOURCES = await res.json();

        placeMarkers(RESOURCES);
        applyFilters();
    } catch (err) {
        loadmsg.innerHTML = '<div class="loadingMSG" style="color:red;">Failed to load resources. Please try refreshing the page.</div>'
        console.error("loadResources error:", err);
    }
}

// Boot
document.addEventListener("DOMContentLoaded", () => {
    loadResources();

    document.getElementById("searchInput").addEventListener("input", applyFilters);
});
        