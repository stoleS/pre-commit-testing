echo 'installing pre-commit script...'
cp ./scripts/pre-commit.sh .git/hooks/pre-commit
echo 'making it executable...'
chmod +x .git/hooks/pre-commit