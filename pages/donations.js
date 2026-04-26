// Category config

const cat_colors = {
    "food": "lightgreen",
    "household": "orange",
    "clothing":  "slateblue",
    "personal care": "purple",
    "baby items": "lightblue",
    "toys": "pink",
    "bedding": "saddlebrown"
};

const cat_labels = {
    "food": "food",
    "household": "household",
    "clothing": "clothing",
    "personal care": "personal",
    "baby items": "baby",
    "toys": "toy",
    "bedding": "bedding"
};

// Map state
let DONATIONS = [];
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

async function loadDonations() {
    const loadmsg = document.getElementById("searchResults");
    loadmsg.innerHTML = '<div class="loadingMSG">Loading donations...</div>';

    try {
        const don = await fetch("get_donations.php");
        if(!don.ok) throw new Error(`HTTP ${don.status}`);
        DONATIONS = await don.json();

        placeMarkers(DONATIONS);
        applyFilters();
    } catch (err) {
        loadmsg.innerHTML = '<div class="loadingMSG" style="color:red;">Failed to load donations. Please try refreshing the page.</div>'
        console.error("loadResources error:", err);
    }
}

// Boot
document.addEventListener("DOMContentLoaded", () => {
    loadDonations();

    document.getElementById("searchInput").addEventListener("input", applyFilters);
});
        