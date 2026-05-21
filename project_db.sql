-- PROJECT

INSERT INTO PROJECT (status, description, developer_id) VALUES
  ('Active',    'A mobile app for tracking personal fitness goals and workouts.', 1),
  ('Active',    'A web-based dashboard for monitoring IoT sensor data in real time.', 6),
  ('Pending',   'An API integration layer connecting multiple third-party payment gateways.', 1),
  ('Completed', 'A static documentation site generator for internal developer tools.', 6),
  ('Active',    'A community forum platform for software developers.', 12),
  ('Pending',   'An e-learning portal with course management and progress tracking.', 13),
  ('Active',    'A real-time chat application with end-to-end encryption.', 15),
  ('Pending',   'A data analytics pipeline for processing large CSV datasets.', 16),
  ('Archived',  'A legacy data migration script for moving records from MySQL to PostgreSQL.', 1);

-- PROJECT_CATEGORY
INSERT INTO PROJECT_CATEGORY (project_id, category) VALUES
  (1, 'A'),
  (1, 'C'),
  (2, 'B'),
  (2, 'D'),
  (3, 'A'),
  (3, 'B'),
  (4, 'C'),
  (5, 'A'),
  (5, 'D'),
  (6, 'B'),
  (6, 'C'),
  (7, 'A'),
  (8, 'B'),
  (8, 'D'),
  (9, 'D');

-- PROJECT_UPDATE
INSERT INTO PROJECT_UPDATE (update_id, project_id, developer_id, name, status, description, type) VALUES
  (1, 1, 1,  'v1.0 Initial Release',      'Published', 'First public release with core workout tracking features.',               1),
  (2, 1, 1,  'v1.1 Bug Fix',              'Published', 'Fixed crash on iOS when logging more than 10 exercises.',                 2),
  (3, 2, 6,  'v1.0 Dashboard Launch',     'Published', 'Initial dashboard with live chart rendering for 5 sensor types.',        1),
  (4, 2, 6,  'Hotfix — Null Sensor Read', 'Published', 'Patched null pointer exception when a sensor goes offline mid-read.',    3),
  (5, 3, 1,  'v0.9 Beta',                 'Draft',     'Beta integration with Stripe and M-Pesa payment APIs.',                  1),
  (6, 4, 6,  'v2.0 Theme Engine',         'Reviewed',  'Added support for custom CSS themes in generated documentation sites.',  1),
  (7, 5, 12, 'v1.0 Forum Launch',         'Published', 'Launched core forum with thread creation and user voting.',              1),
  (8, 5, 12, 'v1.1 Moderation Tools',     'Draft',     'Added post flagging and moderator dashboard.',                           1),
  (9, 6, 13, 'v0.1 Course Builder',       'Draft',     'Initial course creation and enrollment flow.',                           1),
  (10, 7, 15, 'v1.0 Chat Core',            'Published', 'End-to-end encrypted messaging with group chat support.',               1),
  (11, 7, 15, 'Hotfix — Message Delay',    'Published', 'Resolved message delivery lag under high concurrency.',                  3),
  (12, 8, 16, 'v0.5 Pipeline Alpha',       'Draft',     'Alpha pipeline supporting CSV ingestion and basic aggregation.',         1),
  (13, 9, 1,  'Migration Patch',           'Published', 'Fixed foreign key constraint errors during batch record migration.',     2);
