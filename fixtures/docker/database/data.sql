# the organizations table
# an organization can either be a GitHub organization or a GitHub user
CREATE TABLE organizations (
    name VARCHAR(255) NOT NULL PRIMARY KEY,
    plan VARCHAR(255) NOT NULL,
    members JSON,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO organizations(name, plan) VALUES
('runway', 'enterprise'),
('monalisa', 'free'),
('lisamona', 'team');
