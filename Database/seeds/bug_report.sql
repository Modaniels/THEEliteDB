-- BUG_REPORT
INSERT INTO BUG_REPORT (project_id, bug_id, subscriber_id, description, file_date) VALUES

(1, 1, 3,  'App crashes on iOS when logging more than 10 exercises.', '2026-01-22'),
(1, 2, 9,  'Step counter resets to zero when switching between metric and imperial units.', '2026-02-05'),
(2, 1, 8,  'Null pointer exception thrown when a sensor goes offline mid-read.', '2026-02-10'),
(4, 1, 5,  'Custom CSS themes not being applied in generated documentation output.', '2026-03-20'),
(5, 4, 11, 'Moderator dashboard does not display flagged posts from archived threads.', '2026-05-08'),
(7, 1, 5,  'Message delivery lag observed under high concurrency in group chats.', '2026-05-08'),
(9, 1, 3,  'Foreign key constraint errors encountered during batch record migration.', '2026-02-01');