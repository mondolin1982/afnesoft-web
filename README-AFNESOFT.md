# Afnesoft cloud library

The existing Arabic landing page is preserved. catalog.html is the public software/video library. The cloud resources have not been created or deployed by this commit.

## Supabase
1. Create a project on the Free plan.
2. Run supabase/schema.sql in SQL Editor.
3. Create your administrator in Authentication > Users.
4. Copy the Project URL and anon/publishable key into config.js.
5. Never put the service-role key in browser files.

## Cloudflare R2 and Worker
Create an R2 bucket for downloadable files and a Cloudflare Worker API. The Worker must validate the Supabase access token, allow only your admin email to upload/edit/delete, store files in a private R2 bucket, and serve downloads only when the linked resource is published. Do not expose R2 credentials in the browser.

## Publish
The new catalog files live at the repository root. When the existing Cloudflare Pages project deploys this branch, test /catalog.html. Configure the public API URL in config.js after deployment.

## Free-tier notes
Free plans have storage, bandwidth, request, and inactivity limits. Video files should initially be embedded from YouTube rather than uploaded to R2. Test authentication, upload, direct download, and unpublished-file access before sharing the site.