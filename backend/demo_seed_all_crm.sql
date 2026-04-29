START TRANSACTION;

INSERT INTO xformsales_lead_score (lead_id_fk, score, grade, top_factors, calculated_at)
SELECT l.lead_id,
       CASE
         WHEN l.lead_status = 'Qualified Lead' THEN 84
         WHEN l.lead_status = 'Negotiation' THEN 78
         WHEN l.lead_status = 'QuotationSent' THEN 74
         WHEN l.lead_status = 'Working' THEN 66
         WHEN l.lead_status = 'Contacted' THEN 52
         WHEN l.lead_status = 'New Lead' THEN 40
         ELSE 35
       END,
       CASE
         WHEN l.lead_status = 'Qualified Lead' THEN 'A'
         WHEN l.lead_status IN ('Negotiation','QuotationSent') THEN 'B'
         WHEN l.lead_status IN ('Working','Contacted') THEN 'C'
         ELSE 'D'
       END,
       JSON_ARRAY(CONCAT('Status: ', COALESCE(l.lead_status,'Unknown')), CONCAT('Source: ', COALESCE(l.lead_source,'Unknown'))),
       NOW()
FROM xformsales_lead l
LEFT JOIN xformsales_lead_score s ON s.lead_id_fk = l.lead_id
WHERE s.lead_id_fk IS NULL;

INSERT INTO xformsales_user (created_date, password, role, user_email, username)
SELECT CURDATE(), '$2y$05$5TlY6VsuouSOkBQraVIGQ.1gFFwiP52/zNCQoYk/2.H0dj.wiFqdG', 'Sales Manager', 'manager.demo@crm.local', 'manager.demo'
WHERE NOT EXISTS (SELECT 1 FROM xformsales_user WHERE user_email='manager.demo@crm.local');
INSERT INTO xformsales_user (created_date, password, role, user_email, username)
SELECT CURDATE(), '$2y$05$5TlY6VsuouSOkBQraVIGQ.1gFFwiP52/zNCQoYk/2.H0dj.wiFqdG', 'Sales Executive', 'executive.demo@crm.local', 'executive.demo'
WHERE NOT EXISTS (SELECT 1 FROM xformsales_user WHERE user_email='executive.demo@crm.local');
INSERT INTO xformsales_user (created_date, password, role, user_email, username)
SELECT CURDATE(), '$2y$05$5TlY6VsuouSOkBQraVIGQ.1gFFwiP52/zNCQoYk/2.H0dj.wiFqdG', 'Lead Qualifier', 'qualifier.demo@crm.local', 'qualifier.demo'
WHERE NOT EXISTS (SELECT 1 FROM xformsales_user WHERE user_email='qualifier.demo@crm.local');
INSERT INTO xformsales_user (created_date, password, role, user_email, username)
SELECT CURDATE(), '$2y$05$5TlY6VsuouSOkBQraVIGQ.1gFFwiP52/zNCQoYk/2.H0dj.wiFqdG', 'Account Manager', 'account.demo@crm.local', 'account.demo'
WHERE NOT EXISTS (SELECT 1 FROM xformsales_user WHERE user_email='account.demo@crm.local');

INSERT IGNORE INTO xformsales_permission (role_id_fk, grp_perm) VALUES
(1,'dashboard.view'),(1,'leads.view'),(1,'leads.create'),(1,'leads.edit'),(1,'leads.delete'),(1,'opportunities.view'),(1,'projects.view'),(1,'tasks.view'),(1,'reports.view'),
(2,'dashboard.view'),(2,'leads.view'),(2,'leads.create'),(2,'leads.edit'),(2,'opportunities.view'),(2,'opportunities.create'),(2,'tasks.view'),
(3,'dashboard.view'),(3,'leads.view'),(3,'leads.create'),(3,'opportunities.view'),(3,'tasks.view'),
(4,'dashboard.view'),(4,'leads.view'),(4,'leads.edit'),(4,'tasks.view'),
(5,'dashboard.view'),(5,'contacts.view'),(5,'organizations.view'),(5,'projects.view'),
(6,'dashboard.view'),(6,'tasks.view'),(6,'tickets.view');

INSERT IGNORE INTO xformsales_create_team (role_id_fk, team_id_fk, team_member_id_fk) VALUES
(2,1,1),(3,1,2),(2,2,3),(4,2,4),(3,3,5),(2,3,6),(5,4,7),(4,4,8),(2,5,9),(3,5,10);

COMMIT;
