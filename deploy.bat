@ECHO off

echo "Deleting old publication"
rmdir /s /q public
mkdir public
git worktree prune
rmdir /s /q .git/worktrees/public/


echo "Checking out gh-pages branch into public"
echo=>./public/.nojekyll
git worktree add -B gh-pages public origin/gh-pages

echo "Removing existing files"
rmdir /s /q public/

echo "Generating site"
git submodule update --init --recursive --depth=1
hugo --minify

echo "Updating gh-pages branch"
cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"

git push --all
