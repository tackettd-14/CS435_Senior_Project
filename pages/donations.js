// Category config

const cat_colors = {
    "Food": "lightgreen",
    "Cleaning Supplies/Household items": "orange",
    "Clothing": "slateblue",
    "Personal Hygiene Items": "purple",
    "Baby items": "lightblue",
    "Toys": "pink",
    "Bedding": "saddlebrown"
};

const cat_labels = {
    "food": "Food",
    "household": "Cleaning Supplies/Household items",
    "clothing": "Clothing",
    "personal": "Personal Hygiene Items",
    "baby": "Baby items",
    "toy": "Toys",
    "bedding": "Bedding"
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
const zoom = 12;
const lat = 41.97787;
const lng = -91.66562;

map = L.map("map", config).setView([lat, lng], zoom);

// Used to load and display tile layers on the map
L.tileLayer("https://tile.openstreetmap.org/{z}/{x}/{y}.png", {
    attribution:
    '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
}).addTo(map);

function placeMarkers(donations) {
    // Clear existing markers
    Object.values(markers).forEach(m => map.removeLayer(m));
    markers = {};

    donations.forEach(r => {
        if (!r.lat || !r.lng) return;

        const color = r.categories.length > 0 ? (cat_colors[r.categories[0]] || "#888") : "#888";

        const icon = L.divIcon({
            className: "",
            html: `<div style="
                width:28px;height:28px;
                background:${color};
                border:2.5px solid #fff;
                border-radius:50% 50% 50% 4px;
                transform:rotate(-45deg);
                box-shadow:0 2px 8px rgba(0,0,0,0.22);
            "></div>`,
            iconSize: [28, 28],
            iconAnchor: [14, 28],
            popupAnchor: [0, -32]
        });

        // Build display
        const hoursDisplay = r.hours && r.hours.length > 0
            ? r.hours.slice(0, 2).map(h => `${h.day} ${h.open}–${h.close}`).join(", ") : "Hours not listed";

        const isOpen = checkOpen(r.hours);
        const statusHtml = isOpen
            ? `<span class="popup-status open">Open now</span>` : `<span class="popup-status closed">Closed</span>`;

        const popup = L.popup({ closeButton: false, maxWidth: 240 }).setContent(`
            <div class="popup-inner">
                <div style="display:flex; align-items:flex-start; justify-content:space-between; gap:8px; margin-bottom:4px;">
                    <div class="popup-name">${r.name}</div>
                    ${statusHtml}
                </div>
                <div class="popup-metadata">
                    ${r.address}, ${r.city}, ${r.state}, (${r.area_code}) ${r.phone}<br/>
                    ${hoursDisplay}
                </div>
                <div class="popup-tags">
                    ${r.categories.slice(0, 2).map(d => `<span class="popup-tag">${d}</span>`).join("")}
                </div>
            </div>
            <div class="popup-footer">
                ${r.website && r.website !== "N/A"
                    ? `<a href="${r.website}" target="_blank" rel="noopener">Visit website →</a>`
                    : `<span style="font-size:12px; color:#999;">No website listed</span>`}
            </div>
        `);

        const marker = L.marker([r.lat, r.lng], { icon })
            .addTo(map)
            .bindPopup(popup);

        marker.on("click", () => highlightCard(r.id));
        markers[r.id] = marker;
    });

    updateOpenCount(donations);
}

// Check if resource is currently open
function checkOpen(hours) {
    if (!hours || hours.length === 0) return false;
    const now = new Date();
    const dayNames = ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"];
    const todayName = dayNames[now.getDay()];
    const currentMinutes = now.getHours() * 60 + now.getMinutes();

    return hours.some(h => {
        if (h.day !== todayName) return false;
        const [openH, openM]   = h.open.split(":").map(Number);
        const [closeH, closeM] = h.close.split(":").map(Number);
        const openMin  = openH  * 60 + openM;
        const closeMin = closeH * 60 + closeM;
        return currentMinutes >= openMin && currentMinutes < closeMin;
    });
}

function updateOpenCount(donations) {
    const count = donations.filter(r => checkOpen(r.hours)).length;
    document.getElementById("openCount").textContent = count;
}

// Render donations

// Cards
function renderDonation(r) {
    const isOpen = checkOpen(r.hours);
    const badgeHtml = isOpen ? `<span class="rc-badge badge-open">Open now</span>` 
        : `<span class="rc-badge badge-closed">Closed</span>`;

    const hoursShort = r.hours && r.hours.length > 0
        ? `${r.hours[0].day} ${r.hours[0].open}–${r.hours[0].close}`
          + (r.hours.length > 1 ? ` +${r.hours.length - 1} more` : "")
        : "Hours not listed";

    const donationTags = r.categories.slice(0, 4).map(d => {
        const bg = cat_colors[d] || "#aaa";
        return `<span class="rc-tag" style="background:${bg}55; color:${bg}; border-color:${bg}55;">${d}</span>`;
    }).join("");

    const borderColor = r.categories.length > 0 ? (cat_colors[r.categories[0]] || "#888") : "#888";

    return `
        <div class="resource-card" id="card-${r.id}"
             style="border-left-color:${borderColor};"
             onclick="cardClick(${r.id})">
            <div class="rc-name">${badgeHtml}${r.name}</div>
            <div class="rc-meta">
                ${r.address}, ${r.city}<br/>
                ${hoursShort}
            </div>
            <div class="rc-tags">${donationTags}</div>
        </div>
    `;
}

function renderDonations(donations) {
    const container = document.getElementById("searchResults");
    const noResults = document.getElementById("noResults");
    const count     = document.getElementById("resultsCount");

    if (donations.length === 0) {
        container.innerHTML = "";
        noResults.classList.add("visible");
        count.textContent = "0 results";
    } else {
        noResults.classList.remove("visible");
        container.innerHTML = donations.map(renderDonation).join("");
        count.textContent = `${donations.length} result${donations.length !== 1 ? "s" : ""}`;
    }
}

// Search bar

// Filters
function applyFilters() {
    const query = document.getElementById("searchInput").value.trim().toLowerCase();
    const clearBtn = document.getElementById("clearSearch");
    clearBtn.classList.toggle("visible", query.length > 0);

    let results = DONATIONS;

    // Category
    if (activeFilter === "open") {
        results = results.filter(r => checkOpen(r.hours));
    } else if (activeFilter !== "all") {
        const targetCategory = cat_labels[activeFilter];
        if(targetCategory) {
            results = results.filter(r => r.categories.includes(targetCategory));
        }
    }

    // Text search
    if (query) {
        results = results.filter(r => {
            const haystack = [
                r.name, r.address, r.city,
                ...r.categories, r.description
            ].join(" ").toLowerCase();
            return haystack.includes(query);
        });
    }

    renderDonations(results);
    updateMarkerVisibility(results);
    updateOpenCount(results);
}

function filterCategory(cat, el) {
    activeFilter = cat;
    document.querySelectorAll(".filterbtn").forEach(b => b.classList.remove("active"));
    el.classList.add("active");
    applyFilters();
}

function clearSearch() {
    document.getElementById("searchInput").value = "";
    document.getElementById("clearSearch").classList.remove("visible");
    applyFilters();
    document.getElementById("searchInput").focus();
}

function updateMarkerVisibility(visible) {
    const visibleIds = new Set(visible.map(r => r.id));
    Object.entries(markers).forEach(([id, m]) => {
        const el = m.getElement();
        if (el) el.style.opacity = visibleIds.has(parseInt(id)) ? "1" : "0.18";
    });
}

function cardClick(id) {
    const r = DONATIONS.find(x => x.id === id);
    if (!r || !markers[r.id]) return;
    map.flyTo([r.lat, r.lng], 15, { animate: true, duration: 0.8 });
    markers[r.id].openPopup();
    highlightCard(id);
}

// Highlight cards
function highlightCard(id) {
    document.querySelectorAll(".resource-card").forEach(el => el.classList.remove("highlighted"));
    const card = document.getElementById("card-" + id);
    if (card) {
        card.classList.add("highlighted");
        card.scrollIntoView({ behavior: "smooth", block: "nearest" });
    }
}

// Fetch resources from PHP file
async function loadDonations() {
    const container = document.getElementById("searchResults");
    container.innerHTML = `<div class="loading-msg">Loading donations…</div>`;

    try {
        const res = await fetch("php/get_donations.php");
        if (!res.ok) throw new Error(`HTTP ${res.status}`);
        DONATIONS = await res.json();

        placeMarkers(DONATIONS);
        applyFilters();
    } catch (err) {
        container.innerHTML = `<div class="loading-msg" style="color:#c00;">
            Failed to load Donations. Please try refreshing the page.<br/>
            <small>${err.message}</small></div>`;
        console.error("loadResources error:", err);
    }
}

// Boot
document.addEventListener("DOMContentLoaded", () => {
    loadDonations();

    document.getElementById("searchInput").addEventListener("input", applyFilters);
});