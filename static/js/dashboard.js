//defer so that script should not load before DOM...
// content area javascript
function showTab(tabId) {
  document
    .querySelectorAll(".dummy-content")
    .forEach((content) => content.classList.add("d-none"));
  document.getElementById(tabId).classList.remove("d-none");
  document.getElementById("breadcrumb").textContent =
    tabId.charAt(0).toUpperCase() + tabId.slice(1).replace("-", " ");
}
// logout alert javascript
function logout() {
  alert("Logging out...");
  window.location.href = "logout.do";
}
// javascript for sidebar open on small screens
function toggleSidebar() {
  document.querySelector(".sidebar").classList.toggle("active");
}

//###################### property card script start ############################

// document.querySelectorAll(".view-details-btn").forEach(btn => {
//     btn.addEventListener('click', () => {
//         document.querySelector('.card-inner').classList.add('flipped');
//     });
// });
// document.querySelectorAll(".back-btn").forEach(btn => {
//     btn.addEventListener('click', () => {
//         document.querySelector('.card-inner').classList.remove('flipped');
//     });
// });

// document.querySelectorAll(".view-details-btn").forEach((btn) => {
//   btn.addEventListener("click", () => {
//     const cardInner = btn
//       .closest(".property-card")
//       .querySelector(".card-inner");
//     cardInner.classList.add("flipped");
//   });
// });

// document.querySelectorAll(".back-btn").forEach((btn) => {
//   btn.addEventListener("click", () => {
//     const cardInner = btn
//       .closest(".property-card")
//       .querySelector(".card-inner");
//     cardInner.classList.remove("flipped");
//   });
// });
//###################### property card script end ##############################

function getAreasLI(areas) {
  // console.log(areas);
  let ans = "";
  areas.forEach((prtArea) => {
    ans += `
            <li>
                <i class="fas fa-vector-square text-primary me-2"></i>
                <span class="fw-semibold">${prtArea.areaType.type}: </span>${prtArea.area} Sq.ft.
            </li>
        `;
  });
  return ans;
}

function getFeaturesLI(features) {
  // console.log(features);
  let ans = "";
  features.forEach((prtFeature) => {
    ans += `
                <li><i class="fas fa-check-circle text-success me-2"></i>
                    <span class="fw-semibold">${prtFeature.feature.title}:</span>${prtFeature.description}km
                </li>
            `;
  });
  return ans;
}

function getMediasList(medias, propertyId) {
  // console.log(medias);

  let ans = "";
  let flag = true;

  medias.forEach((prtmedia) => {
    if(prtmedia.mediaType) {
      ans += `
              <div class="carousel-item h-100 ${flag ? 'active' : ''} position-relative">
                  <video class="d-block w-100 h-100 object-fit-cover" autoplay muted loop>
                      <source src="getMedia.do?propertyId=${propertyId}&media=${prtmedia.mediaPath}" type="video/mp4">
                  </video>
                  <div class="view-type-label">View Type: ${prtmedia.viewType.viewType}</div>
              </div>
            `;
    } else {
      ans += `
              <div class="carousel-item ${flag ? 'active' : ''} h-100 position-relative">
                  <img src="getMedia.do?propertyId=${propertyId}&media=${prtmedia.mediaPath}" class="d-block w-100 h-100 object-fit-cover" alt="Property Image">
                  <div class="view-type-label">View Type: ${prtmedia.viewType.viewType}</div>
              </div>
            `;
    }

    flag = false;
  });

  return ans;
}

// AJAX request to fetch properties

document.addEventListener("DOMContentLoaded", () => {
  const req = new XMLHttpRequest();   
  req.open("GET", "getMyProperties.do", true);
  req.addEventListener("readystatechange", () => {
    if (req.readyState == 4 && req.status == 200) {
      const data = JSON.parse(req.responseText);
      const propertiesContainer = document.getElementById("properties");
      propertiesContainer.innerHTML = ""; // Clear existing content

      if(data.length == 0){
        propertiesContainer.innerHTML = `<img src="static/media/images/no_property_sold.jpg" class="dummy-img" style="margin-top:150px;" alt="No Properties" /><p>No properties added. Sell your first property right now!</p>`;

      }

      data.forEach((prt) => {
        console.log(prt);
        const propertyCard = document.createElement("div");
        propertyCard.className = "property-card w-100 mb-4";
        propertyCard.innerHTML = `
                            <div class="card-inner">
                        <!-- Front Side -->
                        <div class="card-front">
                            <div class="card rounded-4 shadow-sm border-0 h-100">
                                <div class="row g-0 h-100">
                                    <div class="col-md-4 p-0">
                                        <!-- Carousel Start -->
                                        <div class="carousel slide h-100 rounded-4 position-relative">
                                            <div class="carousel-inner h-100">

                                                ${getMediasList(prt.propertyMedias, prt.property.propertyId)}
                                                
                                            </div>
                                            <button class="carousel-control-prev" type="button">
                                                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                                                <span class="visually-hidden">Previous</span>
                                            </button>
                                            <button class="carousel-control-next" type="button">
                                                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                                                <span class="visually-hidden">Next</span>
                                            </button>
                                        </div>
                                        <!-- Carousel End -->
                                    </div>
                                    <div class="col-md-8 d-flex flex-column justify-content-between">
                                        <div class="card-body px-4 pt-2 pb-0 text-start">
                                            <div class="d-flex justify-content-between mb-2 align-items-start">
                                                <div class="text-warning">
                                                    <i class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                        class="fas fa-star"></i><i class="fas fa-star"></i><i
                                                        class="fas fa-star"></i>
                                                    <small class="text-muted">5.0 (20 Reviews)</small>
                                                </div>
                                                <div class="fw-bold fs-5 text-primary">&#8377;${prt.propertyAction.amount}</div>
                                            </div>
                                            <h5 class="fw-bold mb-2">${prt.property.title}</h5>
                                            <p class="text-muted mb-2"><i class="fas fa-map-marker-alt me-2"></i>
                                            ${prt.property.address}, ${prt.property.city.city}(${prt.property.city.state.state})
                                            </p>
                                            <div class="d-flex mb-2 gap-2 align-items-center">
                                                <span class="desc-label text-secondary">For</span>
                                                <span class="fw-bold text-primary ms-1">
                                                ${prt.propertyAction.actionType ? "Sell" : "Rent"}
                                                </span>
                                                <span class="desc-label text-secondary ms-3">Category</span>
                                                <span class="fw-bold text-primary ms-1">
                                                ${prt.property.propertyType.type}(${prt.property.propertyType.category})</span>
                                                <span class="desc-label text-secondary ms-3">Status</span>
                                                <span class="fw-bold text-primary ms-1">
                                                ${prt.propertyAction.status.status}
                                                </span>
                                            </div>
                                            <div class="bg-light rounded d-flex justify-content-around align-items-center py-3 mb-2">
                                                <div><i class="fas fa-bed icon-thin me-1"></i>
                                                ${prt.property.bhk} BHK
                                                </div>
                                                <div><i class="fas fa-building icon-thin me-1"></i>
                                                ${prt.property.floors} Floors
                                                </div>
                                                <div><i class="fas fa-ruler-combined icon-thin me-1"></i>
                                                ${prt.property.totalArea} sq.ft.
                                                </div>
                                            </div>
                                            <p class="desc-label small mb-1">Description:</p>
                                            <p class="text-muted mb-2">${prt.property.description}.</p>
                                        </div>
                                        <div class="card-footer bg-transparent border-0 text-muted small px-4 d-flex justify-content-between align-items-center">
                                            <div>
                                                <span class="posted-label">Posted on:</span>
                                                <span class="ms-1">
                                                ${prt.propertyAction.postDate.split(",")[0] + "," + prt.propertyAction.postDate.split(",")[1]}
                                                </span>
                                            </div>
                                            <div class="text-end">
                                                <button class="btn btn-primary btn-sm view-details-btn">Extra Info</button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- Back Side -->
                        <div class="card-back">
                            <div class="flex-grow-1 overflow-auto">
                                <div class="card-body px-4 pt-3 pb-0 text-start">
                                    <h5 class="fw-bold mb-2">Additional Area Types</h5>
                                    <ul class="list-unstyled">
                                        ${getAreasLI(prt.propertyAreas)}
                                    </ul>
                                    <h5 class="fw-bold mt-3 mb-2">Property Features</h5>
                                    <ul class="list-unstyled">
                                        ${getFeaturesLI(prt.propertyFeatures)}
                                    </ul>
                                </div>
                            </div>
                            <div class="text-end p-3">
                                <button class="btn btn-primary btn-sm back-btn">Return Back</button>
                            </div>
                        </div>
                    </div>
                        `;
        propertiesContainer.appendChild(propertyCard);
      });

      // Add "Add New Property" button to the properties container
      propertiesContainer.innerHTML += `<a href="addNewProperty.do" class="btn btn-success mb-5"><i class="fa-solid fa-plus me-2"></i> Add New
                    Property</a>`;

      

      // Reinitialize event listeners for new cards
      document.querySelectorAll(".view-details-btn").forEach((btn) => {
        btn.addEventListener("click", () => {
          const cardInner = btn
            .closest(".property-card")
            .querySelector(".card-inner");
          cardInner.classList.add("flipped");
        });
      });

      document.querySelectorAll(".back-btn").forEach((btn) => {
        btn.addEventListener("click", () => {
          const cardInner = btn
            .closest(".property-card")
            .querySelector(".card-inner");
          cardInner.classList.remove("flipped");
        });
      });

      //********************* carousel next and prev button start*********************
      // Initialize all carousels without auto-ride
      document.querySelectorAll(".carousel").forEach((carouselEl) => {
        new bootstrap.Carousel(carouselEl, { ride: false });
      });

      // Handle prev buttons
      document.querySelectorAll(".carousel-control-prev").forEach((btn) => {
        btn.addEventListener("click", function () {
          // Find the carousel this button belongs to...
          const carouselEl = this.closest(".carousel");
          // ...and slide it backwards
          bootstrap.Carousel.getInstance(carouselEl).prev();
        });
      });

      // Handle next buttons
      document.querySelectorAll(".carousel-control-next").forEach((btn) => {
        btn.addEventListener("click", function () {
          const carouselEl = this.closest(".carousel");
          bootstrap.Carousel.getInstance(carouselEl).next();
        });
      });
      //********************* carousel next and prev button end**********************
      
    } else if (req.readyState == 4) {
      console.error("Error fetching properties:", req.statusText);
    }
  });

  req.addEventListener("error", () => {
    console.error("Request failed");
  });

  req.send();
});
