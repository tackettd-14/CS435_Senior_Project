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

function placeMarkers(resources) {
    // Clear existing
    Object.values(markers).forEach(m => map.removeLayer(m));
    markers = {};

    resources.forEach(r => {
        if(!r.lat || r.lng) return;

        const color = cat_colors[r.category] || '#888';

        const icon = L.divIcon({
            className: "",
            html: `<div style="
                width:28px;
                height:28px;
                background:${color};
                border:2.5px solid #fff;
                border-radius:50% 50% 50% 4px;
                transform:rotate(-45deg);
                box-shadow:0 2px 8px rgba(0,0,0,0.22);"></div>`,
                iconSize: [28,28],
                iconAnchor: [14, 28],
                popupAnchor: [0, -32]
        });

        // Build display
        const hoursDisplay = r.hours && r.hours.length > 0
            ? r.hours.slice(0, 2).map(h => `${h.day} ${h.open}-${h.close}`).join(".") : "Hours not listed";
        
        const isOpen = checKOpen(r.hours);
        const statusHTML = isOpen ? '<span class="popup-status open">Open now</span>' : '<span class="popup-status closed">Closed</span>'
        
    })
}

// Search bar

// Filters
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
        