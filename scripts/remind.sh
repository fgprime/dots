osascript - "$1" <<END
on run a
tell app "Reminders"
tell list "Erinnerungen" of default account
make new reminder with properties {name:item 1 of a}
end
end
end
END
