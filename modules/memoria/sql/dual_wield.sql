-- Gives Thief and Dancer dual wield equivalent to Ninja, since their jobs are gimped without it.

-- Thief

UPDATE traits SET level = 10 WHERE traitid = 18 AND job = 6 AND `rank` = 1;
UPDATE traits SET level = 25 WHERE traitid = 18 AND job = 6 AND `rank` = 2;
UPDATE traits SET level = 45 WHERE traitid = 18 AND job = 6 AND `rank` = 3;

INSERT INTO traits (traitid, name, job, level, `rank`, modifier, value, content_tag, meritid) VALUES (18, 'dual wield', 6, 65, 4, 259, 30, 'ABYSSEA', 0);
INSERT INTO traits (traitid, name, job, level, `rank`, modifier, value, content_tag, meritid) VALUES (18, 'dual wield', 6, 85, 5, 259, 35, 'ABYSSEA', 0);

-- Dancer

UPDATE traits SET level = 10 WHERE traitid = 18 AND job = 19 AND `rank` = 1;
UPDATE traits SET level = 25 WHERE traitid = 18 AND job = 19 AND `rank` = 2;
UPDATE traits SET level = 45 WHERE traitid = 18 AND job = 19 AND `rank` = 3;
UPDATE traits SET level = 65 WHERE traitid = 18 AND job = 19 AND `rank` = 4;

INSERT INTO traits (traitid, name, job, level, `rank`, modifier, value, content_tag, meritid) VALUES (18, 'dual wield', 19, 85, 5, 259, 35, 'ABYSSEA', 0);
