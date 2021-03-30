class PropertyQuery {
  static String propertyFields() {
    return """
    {
    _id
    landlord
    address_line
    address_line_2
    city
    state
    zip
    
    # details about a property
    details {
      description
      rooms
      bathrooms
      sq_ft
      furnished
      has_washer
      has_heater
      has_ac
      property_images {
        s3_key
        date_uploaded
      }
    }

    # direction information from a property to nearby institutions
    directions {
      institution_id
      
      foot_walking_directions {
        distance
        coordinates
      }
      
      driving_car_directions {
        distance
        coordinates
      }

      cycling_regular_directions {
        distance
        coordinates
      }
    }
  }""";
  }

  static String searchForPropertyGQL() => """
  query SearchForProperties(
  \$price_start: Float!,
  \$price_end: Float!,
  \$rooms: Int!,
  \$distance: Float!
) {

  searchForProperties (
    price_start: \$price_start,
    price_end: \$price_end,
    rooms: \$rooms,
    distance: \$distance
  ) {
    success
    error
    data {
      search_results {
        property {
          ...PropertyFields
        }
        landlord_first_name
        landlord_last_name
        price_range
        lease_count
        landlord_rating_avg
        property_rating_avg
        landlord_rating_count
        property_rating_count
      }
    }
  }
}
""";

  static String searchForProperty(
          double price_start, double price_end, int rooms, double distance) =>
      """
      query{
        searchForProperties(price_start: $price_start, price_end: $price_end, rooms: $rooms, distance: $distance)
        {
          success
          error
          data {
            search_results {
              property {
                ${propertyFields()}
              }
              landlord_first_name
              landlord_last_name
              price_range
              lease_count
              landlord_rating_avg
              property_rating_avg
              landlord_rating_count
              property_rating_count
            }
          }
        }
      }
    """;
}
