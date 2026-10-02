-- Вставь в Supabase → SQL Editor → Run.
-- Ключ anon потом вставишь на сайте. Он публичный, поэтому сюда нельзя класть телефоны и дом.

create table if not exists profiles (
  nick text primary key,
  skill text default '',
  premium boolean default false,
  updated_at timestamptz default now()
);

create table if not exists spots (
  nick text primary key references profiles(nick) on delete cascade,
  lat double precision,
  lng double precision,
  sharing boolean default false,
  km_today numeric default 0,
  day date default current_date,
  updated_at timestamptz default now()
);

create table if not exists messages (
  id bigint generated always as identity primary key,
  frm text not null,
  to_nick text not null,
  body text default '',
  photo text default '',
  created_at timestamptz default now()
);

create table if not exists places (
  id bigint generated always as identity primary key,
  nick text not null,
  lat double precision,
  lng double precision,
  note text default '',
  created_at timestamptz default now()
);

create table if not exists badges (
  nick text not null,
  code text not null,
  created_at timestamptz default now(),
  primary key (nick, code)
);

alter table profiles enable row level security;
alter table spots enable row level security;
alter table messages enable row level security;
alter table places enable row level security;
alter table badges enable row level security;

create policy "read profiles" on profiles for select using (true);
create policy "write profiles" on profiles for insert with check (true);
create policy "update profiles" on profiles for update using (true);
create policy "read spots" on spots for select using (true);
create policy "write spots" on spots for insert with check (true);
create policy "update spots" on spots for update using (true);
create policy "read messages" on messages for select using (true);
create policy "write messages" on messages for insert with check (true);
create policy "read places" on places for select using (true);
create policy "write places" on places for insert with check (true);
create policy "read badges" on badges for select using (true);
create policy "write badges" on badges for insert with check (true);
