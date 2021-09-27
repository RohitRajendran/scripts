# Closes out all PRs and the related branch for a repo

# Pre-requisites
# - Github CLI (brew install gh)
# - jq commandline json processor (brew install jq)

# Steps:
# 1. cd into the desired repo
# 2. Execute this script. If you get a permission denied error, you will need to run `chmod u+x SCRIPT_FILE`


# Gets a list of pr numbers as a json
PR_LIST=$(gh pr list -L 10000 --json "number"  | jq -c -r '.[]')

# Iterates through each pr number, closing the PR and deleting the branch
for item in ${PR_LIST[@]}; do
  pr_number=$(jq '.number' <<< "$item")
  echo "Deleting PR ${$pr_number}"

  gh pr close $pr_number -d
done
