# Migrations

Consistent standard to write down the migrations - Arrange the fields when creating table as follows:

1. References/Associations
2. Boolean
3. Integer
4. Float
5. Big Integer
6. String
7. Text
8. DateTime
9. Index
10. JSON/JSONB
11. Timestamps

Arrange the grouped fields alphabetically.
<br />
**Note:** Ignore the auto-generated migrations (typically gem dependent) migrations as it is (like `users` table and `solid_queue` and `action_text` migrations etc.)
