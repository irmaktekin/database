



-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.student
(
    student_id integer DEFAULT 1,
    username text NOT NULL,
    surname text NOT NULL,
    birth_date date NOT NULL,
    primary_skill text NOT NULL,
    created_at timestamp without time zone NOT NULL DEFAULT 'NOW()',
    updated_at timestamp without time zone NOT NULL DEFAULT 'NOW()',
    phone_number character varying(11) NOT NULL,
    subject_name "char" NOT NULL,
    PRIMARY KEY (student_id),
	/*check username if it has special characters @,#,$*/
	CONSTRAINT CK_name CHECK(username !~ '^[@#$]')
);

CREATE TABLE IF NOT EXISTS public.exam
(
    exam_id integer,
    exam_name text NOT NULL,
    UNIQUE (exam_id)
);

CREATE TABLE IF NOT EXISTS public.subject
(
    name text NOT NULL,
    tutor text,
    subject_id integer,
    PRIMARY KEY (subject_id)
);

CREATE TABLE IF NOT EXISTS public.student_exam
(
    student_sid integer NOT NULL,
    exam_id serial,
    marks integer,
    PRIMARY KEY (exam_id)
);

CREATE TABLE IF NOT EXISTS public.student_subject
(
    student_sid integer NOT NULL,
    subject_id serial,
    PRIMARY KEY (subject_id)
);

CREATE TABLE IF NOT EXISTS public.adress
(
    adress_id integer,
    postal_code character varying(10),
    street_adress character varying(50),
    PRIMARY KEY (adress_id)
);

CREATE TABLE IF NOT EXISTS public.subject_exam
(
    exam_id integer,
    subject_name text,
    PRIMARY KEY (exam_id)
);

ALTER TABLE IF EXISTS public.student_exam
    ADD FOREIGN KEY (student_sid)
    REFERENCES public.student (student_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.student_exam
    ADD FOREIGN KEY (exam_id)
    REFERENCES public.exam (exam_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.student_subject
    ADD FOREIGN KEY (student_sid)
    REFERENCES public.student (student_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.student_subject
    ADD FOREIGN KEY (subject_id)
    REFERENCES public.subject (subject_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.subject_exam
    ADD FOREIGN KEY (exam_id)
    REFERENCES public.exam (exam_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;