import { Controller } from "@hotwired/stimulus"
import { TabulatorFull as Tabulator } from "tabulator-tables"

// Connects to data-controller="tabulator"
export default class extends Controller {
  static values = {
    url: String,
    columns: Array,
    options: Object
  }

  connect() {
    const defaultOptions = {
      layout: "fitColumns",
      pagination: true,
      paginationMode: "remote",
      paginationSize: 25,
      paginationSizeSelector: [10, 25, 50, 100],
      ajaxURL: this.urlValue,
      ajaxResponse: (url, params, response) => {
        // Expected response format from Pagy:
        // { data: [...], last: totalPages }
        return {
          last_page: response.last || 1,
          data: response.data || []
        }
      },
      ...this.optionsValue
    }

    // Merge columns configuration and process custom formatters
    if (this.hasColumnsValue) {
      defaultOptions.columns = this.columnsValue.map(col => {
        // Add custom date formatter
        if (col.formatter === "customDate") {
          col.formatter = (cell) => {
            const value = cell.getValue()
            if (!value) return ""
            const date = new Date(value)
            return date.toLocaleString('en-US', {
              year: 'numeric',
              month: '2-digit',
              day: '2-digit',
              hour: '2-digit',
              minute: '2-digit',
              hour12: true
            })
          }
        }
        return col
      })
    }

    this.table = new Tabulator(this.element, defaultOptions)
  }

  disconnect() {
    if (this.table) {
      this.table.destroy()
    }
  }

  // Public methods to interact with table
  refresh() {
    if (this.table) {
      this.table.setData()
    }
  }

  getData() {
    return this.table ? this.table.getData() : []
  }
}
