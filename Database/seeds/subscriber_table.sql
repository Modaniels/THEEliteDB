-- Inserting the 6 Subscribers. 
-- IDs 1 and 6 are explicitly flagged as Developers (TRUE).
-- The others rely on the DEFAULT FALSE constraint, or are explicitly declared for clarity.

INSERT INTO SUBSCRIBER (user_id, password, subscription_date, is_developer) VALUES
(1, 'hash_pass_123', '2026-01-15', TRUE),
(3, 'hash_pass_456', '2026-02-20', FALSE),
(5, 'hash_pass_789', '2026-03-10', FALSE),
(6, 'hash_pass_abc', '2026-04-05', TRUE),
(8, 'hash_pass_def', '2026-05-01', FALSE),
(9, 'hash_pass_ghi', '2026-05-18', FALSE);
(11, 'hash_pass_jkl', '2026-06-01', FALSE),
(12, 'hash_pass_mno', '2026-06-05', TRUE),
(13, 'hash_pass_pqr', '2026-06-10', TRUE),
(15, 'hash_pass_vwx', '2026-06-20', TRUE),
(16, 'hash_pass_yz', '2026-06-25', TRUE);
