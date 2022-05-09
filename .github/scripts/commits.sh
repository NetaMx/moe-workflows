COMMITS_COUNT="${COMMITS_COUNT:-3}"

COMMIT_MESSAGES="$(git log "-${COMMITS_COUNT}" --pretty=format:%s | tr ' ' '_*_' | tr '\n' ' ')"
for commit_message in ${COMMIT_MESSAGES}; do
  cleaned_commit_message="$(echo "${commit_message}" | tr '_*_' ' ' )"
  echo "--> Linting commit message [${cleaned_commit_message}]..."
  echo "${cleaned_commit_message}" | commitlint
  test $? -eq 0 || exit 1
done

exit 0