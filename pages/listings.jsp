<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
  <!-- listings tab final design -->
  <!DOCTYPE html>
  <html lang="en">

  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Listings Page</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="static/css/header.css">
    <link rel="stylesheet" href="static/css/footer.css">
    <style>
      .search-container {
        border: 1px solid #ddd;
        display: flex;
        flex-wrap: wrap;
        align-items: center;
        gap: 15px;
        max-width: 1300px;
      }

      .search-container>div {
        flex: 1;
        min-width: 200px;
        border-right: 2px solid #ddd;
        padding-right: 15px;
        display: flex;
        flex-direction: column;
        justify-content: center;
      }

      .search-container>div:last-child {
        border-right: none;
        padding-right: 0;
      }

      .dropdown-checklist {
        flex: 1;
        position: relative;
      }

      .dropdown-checklist .form-label {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding-right: 15px;
        width: 100%;
        font-weight: 500;
        cursor: pointer;
      }

      .dropdown-checklist .dropdown-menu {
        width: 100%;
        padding: 10px;
      }

      .dropdown-toggle::after {
        display: none;
      }

      .horizontal-radio {
        display: flex;
        gap: 15px;
        flex-wrap: wrap;
      }

      @media (max-width: 768px) {
        .search-container {
          flex-direction: column;
          border-radius: 30px;
          padding: 15px;
        }

        .search-container>div {
          border-right: none !important;
          padding-right: 0 !important;
          width: 100%;
        }
      }
    </style>
  </head>

  <body>
    <div>
      <!-- header start -->
      <c:import url="header.jsp" />
      <!-- header end -->

      <!-- Top Black Section -->
      <div class="bg-dark p-5 text-center">
        <h2 class="fw-bold text-white">Listings</h2>
        <div class="text-white">
          <a href="index.do" class="text-warning text-decoration-none">
            <i class="fas fa-home"></i> Home </a>
          <span class="mx-2">&gt;</span>
          Listings
        </div>
      </div>

      <!-- search box -->
      <form id="searchPropertiesForm">
        <div class="search-container bg-white shadow-sm rounded-4 p-4 mx-auto my-3">
          <!-- City Select -->
          <div>
            <div class="d-flex align-items-center">
              <i class="fas fa-location-dot me-2"></i>
              <select class="form-select border-0" name="city" id="city" required>
                <option value="" selected disabled>Select City</option>
                <c:forEach var="ct" items="${cities}">
                  <option value="${ct.city}(${ct.state.state})" data-id="${ct.cityId}">
                    ${ct.city} (${ct.state.state})
                  </option>
                </c:forEach>
              </select>
              <!-- Hidden field to get cities from application -->
              <input type="hidden" name="city_id" id="city_id">
            </div>
          </div>

          <!-- I Want To Dropdown(ActionType selection) -->
          <div class="dropdown dropdown-checklist">
            <label class="form-label dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
              <span><i class="fas fa-handshake me-2"></i> I want to</span>
              <i class="fas fa-angle-down"></i>
            </label>
            <ul class="dropdown-menu">
              <li>
                <div class="form-check horizontal-radio">
                  <input class="form-check-input" type="radio" name="action_type" value="sell" id="sell" checked>
                  <label class="form-check-label" for="sell">Buy</label>
                  <input class="form-check-input ms-4" type="radio" name="action_type" value="rent" id="rent">
                  <label class="form-check-label" for="rent">Rent</label>
                </div>
              </li>
            </ul>
          </div>
          <!-- Property Type Dropdown(category selection) -->
          <div class="dropdown dropdown-checklist">
            <label class="form-label dropdown-toggle" data-bs-toggle="dropdown" aria-expanded="false">
              <span><i class="fas fa-house me-2"></i> Property Type</span>
              <i class="fas fa-angle-down"></i>
            </label>
            <ul class="dropdown-menu">
              <li>
                <div class="form-check horizontal-radio">
                  <input class="form-check-input" type="radio" name="category" value="residental" id="residential" checked>
                  <label class="form-check-label" for="residential">Residential</label>
                  <input class="form-check-input ms-4" type="radio" name="category" value="commercial" id="commercial">
                  <label class="form-check-label" for="commercial">Commercial</label>
                </div>
              </li>
            </ul>
          </div>
          <!-- Search Button -->
          <div>
            <button class="btn btn-warning my-search-btn">
              <i class="fas fa-search me-1"></i>
            </button>
          </div>

        </div>
      </form>

      <div style="height: 1000px;">

        <div class="container-fluid py-4 d-flex justify-content-center">
          <div class="card rounded-3 shadow-sm border-0 overflow-hidden w-100" style="max-width: 1300px;">
            <div class="row g-0">
              <div class="col-md-4">
                <img src="static/media/images/n1.jpg" class="w-100 h-100 object-fit-cover rounded-start-3"
                  alt="Property Image" style="height: 320px;" />
              </div>
              <div class="col-md-8 d-flex flex-column justify-content-between p-3">
                <div>
                  <div class="d-flex justify-content-between align-items-start mb-2">
                    <div class="text-warning">
                      <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                      <i class="fas fa-star"></i><i class="fas fa-star"></i>
                      <small class="text-muted">5.0 (20 Reviews)</small>
                    </div>
                    <div class="fw-bold fs-5 text-primary">&#8377;41,400</div>
                  </div>
                  <h5 class="fw-bold mb-2">Place Perfect For Nature</h5>
                  <p class="text-muted mb-3"><i class="fas fa-map-marker-alt me-2"></i>318–330 S Oakley Blvd,
                    Chicago, IL</p>
                  <div class="bg-light rounded d-flex justify-content-around align-items-center py-2 px-3 mb-3">
                    <div><i class="fas fa-bed me-1 text-primary"></i>2 BHK</div>
                    <div><i class="fas fa-building me-1 text-primary"></i>3 Floors</div>
                    <div><i class="fa-solid fa-chart-area me-1 text-primary"></i>1500 sq.ft.</div>
                  </div>
                  <div class="d-flex justify-content-between text-muted small mb-2">
                    <div>
                      <span class="fw-bold">Posted on:</span><span class="ms-1">17 Jan 2023</span>
                    </div>
                    <div>
                      <span class="fw-bold">Bungalow(Residential)</span>
                    </div>
                  </div>
                  <hr class="my-2" />
                  <div class="d-flex justify-content-between align-items-center">
                    <div class="fw-semibold text-dark">Owner: Rohan Sharma</div>
                    <button class="btn btn-outline-primary btn-sm rounded-2 px-3">
                      <i class="fa-solid fa-phone"></i>
                      Contact</button>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>

        <div class="container-fluid py-4 d-flex justify-content-center">
          <div class="card rounded-3 shadow-sm border-0 overflow-hidden w-100" style="max-width: 1300px;">
            <div class="row g-0">
              <div class="col-md-4">
                <img src="static/media/images/n1.jpg" class="w-100 h-100 object-fit-cover rounded-start-3"
                  alt="Property Image" style="height: 320px;" />
              </div>
              <div class="col-md-8 d-flex flex-column justify-content-between p-3">
                <div>
                  <div class="d-flex justify-content-between align-items-start mb-2">
                    <div class="text-warning">
                      <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                      <i class="fas fa-star"></i><i class="fas fa-star"></i>
                      <small class="text-muted">5.0 (20 Reviews)</small>
                    </div>
                    <div class="fw-bold fs-5 text-primary">&#8377;41,400</div>
                  </div>
                  <h5 class="fw-bold mb-2">Place Perfect For Nature</h5>
                  <p class="text-muted mb-3"><i class="fas fa-map-marker-alt me-2"></i>318–330 S Oakley Blvd,
                    Chicago, IL</p>
                  <div class="bg-light rounded d-flex justify-content-around align-items-center py-2 px-3 mb-3">
                    <div><i class="fas fa-bed me-1 text-primary"></i>2 BHK</div>
                    <div><i class="fas fa-building me-1 text-primary"></i>3 Floors</div>
                    <div><i class="fa-solid fa-chart-area me-1 text-primary"></i>1500 sq.ft.</div>
                  </div>
                  <div class="d-flex justify-content-between text-muted small mb-2">
                    <div>
                      <span class="fw-bold">Posted on:</span><span class="ms-1">17 Jan 2023</span>
                    </div>
                    <div>
                      <span class="fw-bold">Bungalow(Residential)</span>
                    </div>
                  </div>
                  <hr class="my-2" />
                  <div class="d-flex justify-content-between align-items-center">
                    <div class="fw-semibold text-dark">Owner: Rohan Sharma</div>
                    <button class="btn btn-outline-primary btn-sm rounded-2 px-3">
                      <i class="fa-solid fa-phone"></i>
                      Contact</button>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>

        <div class="container-fluid py-4 d-flex justify-content-center">
          <div class="card rounded-3 shadow-sm border-0 overflow-hidden w-100" style="max-width: 1300px;">
            <div class="row g-0">
              <div class="col-md-4">
                <img src="static/media/images/n1.jpg" class="w-100 h-100 object-fit-cover rounded-start-3"
                  alt="Property Image" style="height: 320px;" />
              </div>
              <div class="col-md-8 d-flex flex-column justify-content-between p-3">
                <div>
                  <div class="d-flex justify-content-between align-items-start mb-2">
                    <div class="text-warning">
                      <i class="fas fa-star"></i><i class="fas fa-star"></i><i class="fas fa-star"></i>
                      <i class="fas fa-star"></i><i class="fas fa-star"></i>
                      <small class="text-muted">5.0 (20 Reviews)</small>
                    </div>
                    <div class="fw-bold fs-5 text-primary">&#8377;41,400</div>
                  </div>
                  <h5 class="fw-bold mb-2">Place Perfect For Nature</h5>
                  <p class="text-muted mb-3"><i class="fas fa-map-marker-alt me-2"></i>318–330 S Oakley Blvd,
                    Chicago, IL</p>
                  <div class="bg-light rounded d-flex justify-content-around align-items-center py-2 px-3 mb-3">
                    <div><i class="fas fa-bed me-1 text-primary"></i>2 BHK</div>
                    <div><i class="fas fa-building me-1 text-primary"></i>3 Floors</div>
                    <div><i class="fa-solid fa-chart-area me-1 text-primary"></i>1500 sq.ft.</div>
                  </div>
                  <div class="d-flex justify-content-between text-muted small mb-2">
                    <div>
                      <span class="fw-bold">Posted on:</span><span class="ms-1">17 Jan 2023</span>
                    </div>
                    <div>
                      <span class="fw-bold">Bungalow(Residential)</span>
                    </div>
                  </div>
                  <hr class="my-2" />
                  <div class="d-flex justify-content-between align-items-center">
                    <div class="fw-semibold text-dark">Owner: Rohan Sharma</div>
                    <button class="btn btn-outline-primary btn-sm rounded-2 px-3">
                      <i class="fa-solid fa-phone"></i>
                      Contact</button>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>

      </div>

      <!-- footer start -->
      <c:import url="footer.jsp" />
      <!-- footer end -->

    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
      // script to set city_id hidden field based on user dropdown selection for city
      document.getElementById("city").addEventListener("change", function () {
        var selectedOption = this.options[this.selectedIndex];
        var cityId = selectedOption.getAttribute("data-id");
        document.getElementById("city_id").value = cityId;
      });   

      //script to search properties based on (city_id, action_type, category) form selection
      document.getElementById('searchPropertiesForm').addEventListener('submit', (event) => {
        event.preventDefault();
        const cityId = document.getElementById('city_id').value;
        const actionType = document.querySelector('input[name="action_type"]:checked').value;
        const category = document.querySelector('input[name="category"]:checked').value;
        console.log(cityId);
        console.log(actionType);
        console.log(category);

        const req = new XMLHttpRequest();
        req.open('GET', 'searchProperties.do?city_id=' + encodeURIComponent(cityId) + '&action_type=' + encodeURIComponent(actionType) + '&property_category=' + encodeURIComponent(category), true);
        req.addEventListener('readystatechange', () => {
          if(req.readyState == 4 && req.status == 200) {
            const properties = JSON.parse(req.responseText);

            console.log(properties);

          }
        });

        req.addEventListener('error', () => {
          console.error('Request Failed...');
        });

        req.send();
      });
    </script>
  </body>

  </html>