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

# the commands table
CREATE TABLE commands (
    id VARCHAR(255) NOT NULL PRIMARY KEY,
    organization VARCHAR(255) NOT NULL,
    repository VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    data JSON,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO commands(id, organization, repository, name, data) VALUES
('5ECFDB3A-C229-4982-B5B0-5CC87B8A616A', 'runway', 'test-flight', 'deploy command', '{"name": "deploy command", "description": "Deploy the application", "command": ".deploy"}'),
('8FF93DAA-66DC-4398-9AD7-93A480AC8AD7', 'runway', 'test-flight', 'linter', '{"name": "linter", "description": "it lints things", "command": ".lint"}'),
('58890287-9FF4-4FFA-B671-05AC33B9372E', 'runway', 'fake-repo', 'help', '{"name": "help", "description": "a general help command", "command": ".help"}'),
('5A253C4D-AE3F-4B8D-AABD-F418C34F1D1F', 'monalisa', 'cats', 'help', '{"name": "help", "description": "a general help command", "command": ".help"}'),
('E497B87C-7BC7-4565-8477-54C8F9441CD0', 'lisamona', 'dogs', 'help', '{"name": "help", "description": "a general help command", "command": ".help"}');
