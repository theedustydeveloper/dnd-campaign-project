# Tabulator + Pagy Setup Guide

This Rails app is now configured with Tabulator (data tables) and Pagy (pagination).

## What's Installed

- **Pagy gem** - Efficient pagination
- **Tabulator** - Feature-rich data table library
- **Stimulus controller** - `tabulator_controller.js` to wire everything together

## Usage Example

### 1. Controller Setup

```ruby
# app/controllers/items_controller.rb
class ItemsController < ApplicationController
  include Pagy::Backend

  def index
    # Regular HTML view
  end

  def table_data
    # JSON endpoint for Tabulator
    @pagy, @items = pagy(Item.all, items: params[:size] || 25, page: params[:page] || 1)

    render json: {
      data: @items.as_json,
      last: @pagy.last
    }
  end
end
```

### 2. Routes

```ruby
# config/routes.rb
resources :items do
  collection do
    get :table_data
  end
end
```

### 3. View Template

```erb
<!-- app/views/items/index.html.erb -->
<div
  data-controller="tabulator"
  data-tabulator-url-value="<%= table_data_items_path %>"
  data-tabulator-columns-value='[
    {"title": "Name", "field": "name"},
    {"title": "Description", "field": "description"},
    {"title": "Created", "field": "created_at"}
  ]'>
</div>
```

### 4. Advanced Options

You can pass additional Tabulator options via the `data-tabulator-options-value` attribute:

```erb
<div
  data-controller="tabulator"
  data-tabulator-url-value="<%= table_data_items_path %>"
  data-tabulator-columns-value='[
    {"title": "Name", "field": "name", "sorter": "string"},
    {"title": "HP", "field": "hp", "sorter": "number"},
    {"title": "Actions", "formatter": "buttonCross"}
  ]'
  data-tabulator-options-value='{
    "height": "400px",
    "selectable": true,
    "movableColumns": true
  }'>
</div>
```

## Tabulator Features Available

- Sorting (click column headers)
- Filtering
- Pagination (handled by Pagy)
- Row selection
- Inline editing
- Custom formatters
- Responsive design
- Export to CSV/JSON/PDF
- And much more!

## Resources

- [Tabulator Documentation](http://tabulator.info/)
- [Pagy Documentation](https://ddnexus.github.io/pagy/)
- Stimulus controller: `app/javascript/controllers/tabulator_controller.js`

## Need Help?

The Stimulus controller is fully configured for remote pagination with Pagy. Just:
1. Create a JSON endpoint in your controller
2. Use Pagy to paginate your data
3. Return `{ data: [...], last: total_pages }`
4. Add the HTML div with proper data attributes
