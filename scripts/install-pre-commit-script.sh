echo 'installing pre-commit script...'
ln -s ./scripts/pre-commit.sh .git/hooks/pre-commit
echo 'making it executable...'
chmod +x .git/hooks/pre-commit
echo 'everyting set!'