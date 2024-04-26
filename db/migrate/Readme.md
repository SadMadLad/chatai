# Migrations

Consistent standard to write down the migrations - Arrange the fields when creating table as follows:

1. References/Associations
2. Integer
3. Float
4. Big Integer
5. String
6. Text
7. DateTime
8. Index
9. JSON/JSONB
10. Timestamps

Arrange the grouped fields alphabetically.
<br />
**Note:** Ignore the auto-generated migrations (typically gem dependent) migrations as it is (like `users` table and `solid_queue` and `action_text` migrations etc.)
