create table topic_quarter_reports (
    id bigserial primary key,

    topic_id bigint not null references topics(id) on delete cascade,

    period_start date not null,
    period_end date not null,
    period_key text not null,

    title text,
    summary text,

    definition text,
    dynamics_summary text,
    future_dynamics text,

    metrics jsonb not null default '{}'::jsonb,
    keyword_dynamics jsonb not null default '{}'::jsonb,

    created_at timestamptz not null default now(),
    updated_at timestamptz not null default now(),

    unique (topic_id, period_key)
);

create table topic_quarter_report_items (
    id bigserial primary key,

    report_id bigint not null references topic_quarter_reports(id) on delete cascade,

    -- 'research_problem' | 'method' | 'approach' | 'future_direction'
    item_type text not null,

    title text not null,
    description text,

    -- 'emerging' | 'growing' | 'stable' | 'declining' | 'mature'
    maturity text,

    evidence jsonb not null default '{}'::jsonb,

    sort_order integer not null default 0,
    created_at timestamptz not null default now()
);

create table topic_quarter_report_papers (
    report_id bigint not null references topic_quarter_reports(id) on delete cascade,
    paper_id bigint not null references papers(id) on delete cascade,

    -- 'representative' | 'highly_cited' | 'emerging' | 'method_evidence' | 'problem_evidence'
    role text not null,

    score numeric(10, 5),
    note text,

    primary key (report_id, paper_id, role)
);