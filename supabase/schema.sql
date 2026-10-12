-- Run in the Supabase SQL Editor.
create extension if not exists pgcrypto;
create table if not exists public.resources (
 id uuid primary key default gen_random_uuid(),
 type text not null check (type in ('software','video')),
 title_ar text not null default '', title_en text not null default '',
 description_ar text not null default '', description_en text not null default '',
 category text not null default 'عام', version text not null default '1.0',
 file_key text, file_name text, file_size bigint, video_url text, thumbnail_url text,
 downloads bigint not null default 0, published boolean not null default false,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create index if not exists resources_published_created_idx on public.resources(published,created_at desc);
alter table public.resources enable row level security;
drop policy if exists "Anyone can read published resources" on public.resources;
create policy "Anyone can read published resources" on public.resources for select to anon, authenticated using (published=true);
-- Only the Cloudflare Worker may write, using its server-side service-role key.
-- Never expose that key in frontend files.