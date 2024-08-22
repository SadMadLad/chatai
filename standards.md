# Some Standards

* **`TODO:`** highlights stuff that needs to be done. **`TEMP:`** is for temporary statements that should be removed or fixed later.
* Use `flake8` + `black` for Python code, `prettier` for JS and TS, `credo` for Elixir and `rubocop` for Ruby code.
* `<%- %>` should be used to store variables in templates.
* Consistent standard to write down the migrations - Arrange the fields when creating table as follows:
  1. References/Associations
  2. Boolean
  3. Integer
  4. Float
  5. Big Integer
  6. String
  7. Text
  8. DateTime
  9. UUID
  10. Index
  11. JSON/JSONB
  12. Timestamps

  Arrange the grouped fields alphabetically.
  <br />
  **Note:** Ignore the auto-generated migrations (typically gem dependent) migrations as it is (like `users` table and `solid_queue` and `action_text` migrations etc.)
