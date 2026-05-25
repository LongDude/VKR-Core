CREATE TABLE public.author_institutions (
    author_id bigint NOT NULL,
    institution_id bigint NOT NULL
);

CREATE TABLE public.authors (
    id bigint NOT NULL,
    display_name text NOT NULL,
    orcid text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.authors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.domains (
    id bigint NOT NULL,
    openalex_id text,
    name text NOT NULL
);

CREATE SEQUENCE public.domains_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.fields (
    id bigint NOT NULL,
    domain_id bigint,
    openalex_id text,
    name text NOT NULL
);

CREATE SEQUENCE public.fields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.flyway_schema_history (
    installed_rank integer NOT NULL,
    version character varying(50),
    description character varying(200) NOT NULL,
    type character varying(20) NOT NULL,
    script character varying(1000) NOT NULL,
    checksum integer,
    installed_by character varying(100) NOT NULL,
    installed_on timestamp without time zone DEFAULT now() NOT NULL,
    execution_time integer NOT NULL,
    success boolean NOT NULL
);

CREATE TABLE public.institutions (
    id bigint NOT NULL,
    display_name text NOT NULL,
    ror text,
    country_code character(2),
    type text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.institutions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.keywords (
    id bigint NOT NULL,
    value text NOT NULL
);

CREATE SEQUENCE public.keywords_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.landings (
    id bigint NOT NULL,
    paper_id bigint NOT NULL,
    landing_url text NOT NULL,
    pdf_url text,
    license text,
    version text,
    is_best boolean DEFAULT false,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.landings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.openalex_montly_topic_stats (
    id bigint NOT NULL,
    topic_id bigint,
    period_start date NOT NULL,
    works_count integer NOT NULL,
    collected_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.openalex_montly_topic_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.openalex_yearly_topic_stats (
    id bigint NOT NULL,
    topic_id bigint,
    stat_year date NOT NULL,
    works_count integer NOT NULL,
    collected_at timestamp with time zone DEFAULT now() NOT NULL,
    artifical_pubdates_estimation integer DEFAULT 0 CONSTRAINT openalex_yearly_topic_stats_artifical_pubdates_estimat_not_null NOT NULL
);

CREATE SEQUENCE public.openalex_yearly_topic_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.paper_authors (
    paper_id bigint NOT NULL,
    author_id bigint NOT NULL,
    author_order integer,
    is_corresponding boolean DEFAULT false
);

CREATE TABLE public.paper_keywords (
    paper_id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    score numeric(6,5)
);

CREATE TABLE public.paper_topics (
    paper_id bigint NOT NULL,
    topic_id bigint NOT NULL,
    score numeric(6,5)
);

CREATE TABLE public.papers (
    id bigint NOT NULL,
    title text NOT NULL,
    doi text,
    publication_year smallint,
    publication_date date,
    language text,
    abstract text,
    is_open_access boolean,
    cited_by_count integer DEFAULT 0,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    openalex_id text,
    references_count integer DEFAULT 0,
    text_hash text,
    is_indexed boolean DEFAULT false NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL,
    indexed_at timestamp with time zone DEFAULT now() NOT NULL,
    primary_topic_id bigint,
    extracted_keywords jsonb
);

CREATE SEQUENCE public.papers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.research_cluster_period_stats (
    id bigint NOT NULL,
    cluster_id bigint NOT NULL,
    period_start date NOT NULL,
    period_end date NOT NULL,
    paper_count integer DEFAULT 0 NOT NULL,
    previous_paper_count integer DEFAULT 0 NOT NULL,
    growth_rate numeric(10,5),
    trend_score numeric(10,5),
    semantic_drift numeric(10,5),
    citation_count_sum integer DEFAULT 0,
    avg_cited_by_count numeric(10,3),
    top_keywords jsonb,
    representative_paper_ids jsonb,
    summary text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.research_cluster_period_stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.research_clusters (
    id bigint NOT NULL,
    cluster_key text NOT NULL,
    cluster_type text NOT NULL,
    source_topic_id bigint,
    name text NOT NULL,
    summary text,
    status text,
    trend_score numeric(8,5),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.research_clusters_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.subfields (
    id bigint NOT NULL,
    field_id bigint,
    openalex_id text,
    name text NOT NULL
);

CREATE SEQUENCE public.subfields_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.topic_quarter_report_items (
    id bigint NOT NULL,
    report_id bigint NOT NULL,
    item_type text NOT NULL,
    title text NOT NULL,
    description text,
    maturity text,
    evidence jsonb DEFAULT '{}'::jsonb NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.topic_quarter_report_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.topic_quarter_report_papers (
    report_id bigint NOT NULL,
    paper_id bigint NOT NULL,
    role text NOT NULL,
    score numeric(10,5),
    note text
);

CREATE TABLE public.topic_quarter_reports (
    id bigint NOT NULL,
    topic_id bigint NOT NULL,
    period_start date NOT NULL,
    period_end date NOT NULL,
    period_key text NOT NULL,
    summary text,
    period_characterization text,
    dynamics_summary text,
    future_dynamics text,
    metrics jsonb DEFAULT '{}'::jsonb NOT NULL,
    keyword_dynamics jsonb DEFAULT '{}'::jsonb NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.topic_quarter_reports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.topics (
    id bigint NOT NULL,
    subfield_id bigint,
    openalex_id text,
    name text NOT NULL
);

CREATE SEQUENCE public.topics_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.user_favourite_papers (
    user_id bigint NOT NULL,
    paper_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.user_tracked_domains (
    user_id bigint NOT NULL,
    domain_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.user_tracked_fields (
    user_id bigint NOT NULL,
    field_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.user_tracked_keywords (
    user_id bigint NOT NULL,
    keyword_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.user_tracked_subfields (
    user_id bigint NOT NULL,
    subfield_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.user_tracked_topics (
    user_id bigint NOT NULL,
    topic_id bigint NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE TABLE public.users (
    id bigint NOT NULL,
    email text NOT NULL,
    password_hash text NOT NULL,
    password_salt text NOT NULL,
    name text,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER TABLE ONLY public.authors ALTER COLUMN id SET DEFAULT nextval('public.authors_id_seq'::regclass);
ALTER TABLE ONLY public.domains ALTER COLUMN id SET DEFAULT nextval('public.domains_id_seq'::regclass);
ALTER TABLE ONLY public.fields ALTER COLUMN id SET DEFAULT nextval('public.fields_id_seq'::regclass);
ALTER TABLE ONLY public.institutions ALTER COLUMN id SET DEFAULT nextval('public.institutions_id_seq'::regclass);
ALTER TABLE ONLY public.keywords ALTER COLUMN id SET DEFAULT nextval('public.keywords_id_seq'::regclass);
ALTER TABLE ONLY public.landings ALTER COLUMN id SET DEFAULT nextval('public.landings_id_seq'::regclass);
ALTER TABLE ONLY public.openalex_montly_topic_stats ALTER COLUMN id SET DEFAULT nextval('public.openalex_montly_topic_stats_id_seq'::regclass);
ALTER TABLE ONLY public.openalex_yearly_topic_stats ALTER COLUMN id SET DEFAULT nextval('public.openalex_yearly_topic_stats_id_seq'::regclass);
ALTER TABLE ONLY public.papers ALTER COLUMN id SET DEFAULT nextval('public.papers_id_seq'::regclass);
ALTER TABLE ONLY public.research_cluster_period_stats ALTER COLUMN id SET DEFAULT nextval('public.research_cluster_period_stats_id_seq'::regclass);
ALTER TABLE ONLY public.research_clusters ALTER COLUMN id SET DEFAULT nextval('public.research_clusters_id_seq'::regclass);
ALTER TABLE ONLY public.subfields ALTER COLUMN id SET DEFAULT nextval('public.subfields_id_seq'::regclass);
ALTER TABLE ONLY public.topic_quarter_report_items ALTER COLUMN id SET DEFAULT nextval('public.topic_quarter_report_items_id_seq'::regclass);
ALTER TABLE ONLY public.topic_quarter_reports ALTER COLUMN id SET DEFAULT nextval('public.topic_quarter_reports_id_seq'::regclass);
ALTER TABLE ONLY public.topics ALTER COLUMN id SET DEFAULT nextval('public.topics_id_seq'::regclass);
ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);
ALTER TABLE ONLY public.author_institutions
    ADD CONSTRAINT author_institutions_pkey PRIMARY KEY (author_id, institution_id);
ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_orcid_key UNIQUE (orcid);
ALTER TABLE ONLY public.authors
    ADD CONSTRAINT authors_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.domains
    ADD CONSTRAINT domains_name_key UNIQUE (name);
ALTER TABLE ONLY public.domains
    ADD CONSTRAINT domains_openalex_id_key UNIQUE (openalex_id);
ALTER TABLE ONLY public.domains
    ADD CONSTRAINT domains_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_openalex_id_key UNIQUE (openalex_id);
ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.flyway_schema_history
    ADD CONSTRAINT flyway_schema_history_pk PRIMARY KEY (installed_rank);
ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.institutions
    ADD CONSTRAINT institutions_ror_key UNIQUE (ror);
ALTER TABLE ONLY public.keywords
    ADD CONSTRAINT keywords_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.keywords
    ADD CONSTRAINT keywords_value_key UNIQUE (value);
ALTER TABLE ONLY public.landings
    ADD CONSTRAINT landings_paper_id_landing_url_key UNIQUE (paper_id, landing_url);
ALTER TABLE ONLY public.landings
    ADD CONSTRAINT landings_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.openalex_montly_topic_stats
    ADD CONSTRAINT openalex_montly_topic_stats_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.openalex_montly_topic_stats
    ADD CONSTRAINT openalex_montly_topic_stats_topic_id_period_start_key UNIQUE (topic_id, period_start);
ALTER TABLE ONLY public.openalex_yearly_topic_stats
    ADD CONSTRAINT openalex_yearly_topic_stats_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.openalex_yearly_topic_stats
    ADD CONSTRAINT openalex_yearly_topic_stats_topic_id_stat_year_key UNIQUE (topic_id, stat_year);

ALTER TABLE ONLY public.paper_authors
    ADD CONSTRAINT paper_authors_pkey PRIMARY KEY (paper_id, author_id);

ALTER TABLE ONLY public.paper_keywords
    ADD CONSTRAINT paper_keywords_pkey PRIMARY KEY (paper_id, keyword_id);

ALTER TABLE ONLY public.paper_topics
    ADD CONSTRAINT paper_topics_pkey PRIMARY KEY (paper_id, topic_id);

ALTER TABLE ONLY public.papers
    ADD CONSTRAINT papers_doi_key UNIQUE (doi);

ALTER TABLE ONLY public.papers
    ADD CONSTRAINT papers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.research_cluster_period_stats
    ADD CONSTRAINT research_cluster_period_stats_cluster_id_period_start_perio_key UNIQUE (cluster_id, period_start, period_end);

ALTER TABLE ONLY public.research_cluster_period_stats
    ADD CONSTRAINT research_cluster_period_stats_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.research_clusters
    ADD CONSTRAINT research_clusters_cluster_key_key UNIQUE (cluster_key);

ALTER TABLE ONLY public.research_clusters
    ADD CONSTRAINT research_clusters_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.subfields
    ADD CONSTRAINT subfields_openalex_id_key UNIQUE (openalex_id);

ALTER TABLE ONLY public.subfields
    ADD CONSTRAINT subfields_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.topic_quarter_report_items
    ADD CONSTRAINT topic_quarter_report_items_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.topic_quarter_report_papers
    ADD CONSTRAINT topic_quarter_report_papers_pkey PRIMARY KEY (report_id, paper_id, role);

ALTER TABLE ONLY public.topic_quarter_reports
    ADD CONSTRAINT topic_quarter_reports_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.topic_quarter_reports
    ADD CONSTRAINT topic_quarter_reports_topic_id_period_key_key UNIQUE (topic_id, period_key);

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_openalex_id_key UNIQUE (openalex_id);

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.user_favourite_papers
    ADD CONSTRAINT user_favourite_papers_pkey PRIMARY KEY (user_id, paper_id);

ALTER TABLE ONLY public.user_tracked_domains
    ADD CONSTRAINT user_tracked_domains_pkey PRIMARY KEY (user_id, domain_id);

ALTER TABLE ONLY public.user_tracked_fields
    ADD CONSTRAINT user_tracked_fields_pkey PRIMARY KEY (user_id, field_id);

ALTER TABLE ONLY public.user_tracked_keywords
    ADD CONSTRAINT user_tracked_keywords_pkey PRIMARY KEY (user_id, keyword_id);

ALTER TABLE ONLY public.user_tracked_subfields
    ADD CONSTRAINT user_tracked_subfields_pkey PRIMARY KEY (user_id, subfield_id);

ALTER TABLE ONLY public.user_tracked_topics
    ADD CONSTRAINT user_tracked_topics_pkey PRIMARY KEY (user_id, topic_id);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_key UNIQUE (email);

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);

CREATE INDEX flyway_schema_history_s_idx ON public.flyway_schema_history USING btree (success);

CREATE INDEX idx_author_institutions_institution_id ON public.author_institutions USING btree (institution_id);

CREATE INDEX idx_authors_display_name ON public.authors USING btree (display_name);

CREATE INDEX idx_institutions_display_name ON public.institutions USING btree (display_name);

CREATE INDEX idx_landings_paper_id ON public.landings USING btree (paper_id);

CREATE INDEX idx_monthly_stats_topic_id ON public.openalex_montly_topic_stats USING btree (topic_id);

CREATE INDEX idx_paper_authors_author_id ON public.paper_authors USING btree (author_id);

CREATE INDEX idx_paper_keywords_keyword_id ON public.paper_keywords USING btree (keyword_id);

CREATE INDEX idx_paper_topics_topic_id ON public.paper_topics USING btree (topic_id);

CREATE INDEX idx_papers_title ON public.papers USING gin (to_tsvector('simple'::regconfig, title));

CREATE INDEX idx_papers_year ON public.papers USING btree (publication_year);

CREATE INDEX idx_user_favourite_papers_paper_id ON public.user_favourite_papers USING btree (paper_id);

CREATE INDEX idx_yearly_stats_topic_id ON public.openalex_yearly_topic_stats USING btree (topic_id);

ALTER TABLE ONLY public.author_institutions
    ADD CONSTRAINT author_institutions_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.author_institutions
    ADD CONSTRAINT author_institutions_institution_id_fkey FOREIGN KEY (institution_id) REFERENCES public.institutions(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.fields
    ADD CONSTRAINT fields_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES public.domains(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.papers
    ADD CONSTRAINT fk_papers_primary_topic FOREIGN KEY (primary_topic_id) REFERENCES public.topics(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.landings
    ADD CONSTRAINT landings_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES public.papers(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.openalex_montly_topic_stats
    ADD CONSTRAINT openalex_montly_topic_stats_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.openalex_yearly_topic_stats
    ADD CONSTRAINT openalex_yearly_topic_stats_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.paper_authors
    ADD CONSTRAINT paper_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.authors(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.paper_authors
    ADD CONSTRAINT paper_authors_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES public.papers(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.paper_keywords
    ADD CONSTRAINT paper_keywords_keyword_id_fkey FOREIGN KEY (keyword_id) REFERENCES public.keywords(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.paper_keywords
    ADD CONSTRAINT paper_keywords_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES public.papers(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.paper_topics
    ADD CONSTRAINT paper_topics_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES public.papers(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.paper_topics
    ADD CONSTRAINT paper_topics_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.research_cluster_period_stats
    ADD CONSTRAINT research_cluster_period_stats_cluster_id_fkey FOREIGN KEY (cluster_id) REFERENCES public.research_clusters(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.research_clusters
    ADD CONSTRAINT research_clusters_source_topic_id_fkey FOREIGN KEY (source_topic_id) REFERENCES public.topics(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.subfields
    ADD CONSTRAINT subfields_field_id_fkey FOREIGN KEY (field_id) REFERENCES public.fields(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.topic_quarter_report_items
    ADD CONSTRAINT topic_quarter_report_items_report_id_fkey FOREIGN KEY (report_id) REFERENCES public.topic_quarter_reports(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.topic_quarter_report_papers
    ADD CONSTRAINT topic_quarter_report_papers_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES public.papers(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.topic_quarter_report_papers
    ADD CONSTRAINT topic_quarter_report_papers_report_id_fkey FOREIGN KEY (report_id) REFERENCES public.topic_quarter_reports(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.topic_quarter_reports
    ADD CONSTRAINT topic_quarter_reports_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.topics
    ADD CONSTRAINT topics_subfield_id_fkey FOREIGN KEY (subfield_id) REFERENCES public.subfields(id) ON DELETE SET NULL;

ALTER TABLE ONLY public.user_favourite_papers
    ADD CONSTRAINT user_favourite_papers_paper_id_fkey FOREIGN KEY (paper_id) REFERENCES public.papers(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_favourite_papers
    ADD CONSTRAINT user_favourite_papers_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_domains
    ADD CONSTRAINT user_tracked_domains_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES public.domains(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_domains
    ADD CONSTRAINT user_tracked_domains_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_fields
    ADD CONSTRAINT user_tracked_fields_field_id_fkey FOREIGN KEY (field_id) REFERENCES public.fields(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_fields
    ADD CONSTRAINT user_tracked_fields_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_keywords
    ADD CONSTRAINT user_tracked_keywords_keyword_id_fkey FOREIGN KEY (keyword_id) REFERENCES public.keywords(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_keywords
    ADD CONSTRAINT user_tracked_keywords_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_subfields
    ADD CONSTRAINT user_tracked_subfields_subfield_id_fkey FOREIGN KEY (subfield_id) REFERENCES public.subfields(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_subfields
    ADD CONSTRAINT user_tracked_subfields_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_topics
    ADD CONSTRAINT user_tracked_topics_topic_id_fkey FOREIGN KEY (topic_id) REFERENCES public.topics(id) ON DELETE CASCADE;

ALTER TABLE ONLY public.user_tracked_topics
    ADD CONSTRAINT user_tracked_topics_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;
