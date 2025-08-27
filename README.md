# Deploy A Static Website Using Terraform
This project will create an S3 bucket configured for static website hosting.  The site files will be uploaded via Terraform.
## 1 - Prerequites (on your machine or Codespace)
- AWS account & access key (access key id + secret) with permission to create S3 buckets & policies.
- Terraform installed (recommended v1.x). If you’re in a Codespace you can install Terraform with the official binary (or use the HashiCorp Codespace feature).
- `aws` CLI (optional but useful) — configure with `aws configure` or export env vars.
- Git and a GitHub repo to push to.
## 2 - Project layout (create this locally or in Codespace)
<img width="249" height="278" alt="Screen Shot 2025-08-26 at 10 32 24 PM" src="https://github.com/user-attachments/assets/31bd05e8-a03a-4b87-a0bf-4d7a654637b1" /> <br>
Create the folder:
- mkdir -p ~/static-website-terraform/site ~/static-website-terraform/terraform
- cd ~/static-website-terraform
## 3 - Add a tiny sample website
- `site/index.html`
- `site/404.html`
## 4 - Terraform code (copy into `terraform/`)
- `provider.tf`
- `variables.tf`
- `s3.tf` <br>
This config sets website hosting (index + error) and creates a bucket policy to allow public reads. AWS docs require disabling the block-public-access and adding a bucket policy for a public website.
- `outputs.tf`
## 5 - How to run the Terraform deployment (locally or in Codespace)
**A — Set AWS credentials (DO NOT commit these)** <br>

Set environment variables (recommended): <br>
<img width="353" height="127" alt="Screen Shot 2025-08-26 at 11 58 31 PM" src="https://github.com/user-attachments/assets/a562732c-277a-4b34-a103-f226c401c040" /> <br>
(You can also run aws configure locally.) Do not put these in git.

**B — Initialize and apply** <br>
From the terraform/ directory: <br>
<img width="547" height="147" alt="Screen Shot 2025-08-27 at 12 01 54 AM" src="https://github.com/user-attachments/assets/63c964bd-e16a-4cb3-8a58-7297dba858d0" /> <br>
- Approve the apply (type `yes` when prompted).
- After apply completes, Terraform outputs `website_endpoint` — a URL like `your-bucket.s3-website-us-east-1.amazonaws.com`.

(If you prefer to upload many files, you can use `aws s3 sync site/ s3://your-bucket --acl public-read` after creating the bucket; Terraform also supports looping upload patterns but the `aws_s3_bucket_object` example above is explicit.)
## 6 - Verify the site
- Open the `website_endpoint` Terraform output in your browser — you should see `index.html`.
- If you visit a missing page, S3 should return `404.html`.
## 7 - GitHub / Codespaces notes (how to run from Codespace safely)

Do not commit AWS credentials to GitHub. Use one of:

Add AWS credentials as Codespace environment variables (Repository → Settings → Codespaces → Secrets / Codespaces secrets) so they are available inside the Codespace, or

For CI/CD, prefer the GitHub Actions configure-aws-credentials approach (OIDC or short-lived credentials) rather than storing long-lived keys. 
GitHub
AWS Documentation

To run Terraform from a Codespace:

Open the Codespace, open a terminal.

Install Terraform (if not preinstalled) — e.g. in Codespace terminal:

curl -fsSL https://releases.hashicorp.com/terraform/1.5.0/terraform_1.5.0_linux_amd64.zip -o /tmp/tf.zip
unzip /tmp/tf.zip -d /usr/local/bin
terraform -v


(Pick the appropriate Terraform release — you can also use tfenv.)

Export AWS credentials (via Codespace secrets or export in terminal).

cd terraform → terraform init → terraform apply -var="bucket_name=..."
## 8 - Optional: CI/CD with GitHub Actions (quick example)

If you want to auto-deploy on push (only recommended for hobby/demo sites), you can create .github/workflows/terraform.yml that runs terraform apply using the aws-actions/configure-aws-credentials GH Action and a GitHub secret (or OIDC role). See the action docs for secure setup.
