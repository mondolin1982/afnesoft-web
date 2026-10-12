# Afnesoft cloud library

The existing Arabic landing page is preserved. catalog.html is the public software/video library and admin.html is the content manager. This branch adds source code only; it has not created cloud resources or deployed the site.

## Supabase setup
1. Create a project on the Free plan.
2. Run supabase/schema.sql in the Supabase SQL Editor.
3. Create your administrator account in Authentication > Users.
4. Copy the Project URL and anon/publishable key into config.js.
5. Never put the service-role key in browser files.

## Cloudflare R2 and Worker
1. Create an R2 bucket for downloadable files. Keep the bucket private.
2. In worker/wrangler.toml replace the bucket name, admin email, and allowed Pages origin.
3. Install Wrangler, open a terminal in the worker directory, then run: npm install -g wrangler; wrangler login.
4. Run wrangler secret put SUPABASE_URL, wrangler secret put SUPABASE_ANON_KEY, and wrangler secret put SUPABASE_SERVICE_ROLE_KEY. Enter each value only at the secure prompt. Never commit these secrets.
5. Run wrangler deploy. Copy the resulting Worker URL into API_BASE_URL in config.js.
6. Set SUPABASE_URL and SUPABASE_ANON_KEY in config.js too.

The Worker validates Supabase login and allows only the email in ADMIN_EMAIL to upload/edit/delete. Files are stored in private R2 and only downloadable when attached to a published resource. The starter upload limit is 90 MiB to suit the typical free Workers request-body limit.

## Deploy and test
If Cloudflare Pages is connected to this repository, deploy the feature/afnesoft-library branch as a preview if available. Test /catalog.html and /admin.html before merging. Test admin login, upload, direct download, edits, deletion, and ensure unpublished files cannot be downloaded. Existing index.html now links to the library.

## Free-plan limits
Free plans have storage, request, bandwidth, and inactivity limits. Use YouTube embeds for video content initially. Free does not mean unlimited; monitor quotas and review current provider terms before launch.