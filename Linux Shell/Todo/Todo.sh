#!/bin/bash

figlet TODO
# Define file names
UNDONE_FILE="/home/pedram/Desktop/python/HW/HW9/Todo/undone_tasks.txt"
DONE_FILE="/home/pedram/Desktop/python/HW/HW9/Todo/done_tasks.txt"
DELETED_FILE="/home/pedram/Desktop/python/HW/HW9/Todo/deleted_tasks.txt"

# Create files if they don't exist
touch $UNDONE_FILE
touch $DONE_FILE
touch $DELETED_FILE

# Function to add a new task
add_task() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo "Enter task description:"
    read task_description
    echo "Enter priority (1-3):"
    read priority
    echo "Enter date and time (YYYY-MM-DD HH:MM):"
    read datetime

    # Append task details to the undone tasks file
    echo "$priority | $datetime | $task_description" >> $UNDONE_FILE
    echo "Task added: $task_description (Priority: $priority, Due: $datetime)"
}

# Function to show undone tasks
show_undone() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo "Undone tasks:"
    while IFS= read -r line; do
        IFS=" | " read -r priority datetime task_description <<< "$line"
        echo "Priority: $priority, Due: $datetime, Task: $task_description"
    done < "$UNDONE_FILE"
}

# Function to mark a task as done
mark_done() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo "Enter task number to mark as done:"
    read task_number

    # Move task from undone to done
    sed -n "${task_number}p" $UNDONE_FILE >> $DONE_FILE
    sed -i "${task_number}d" $UNDONE_FILE
    echo "Task marked as done."
}

# Function to show completed tasks
show_done() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo "Completed tasks:"
    cat $DONE_FILE
}

# Function to delete a task
delete_task() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo "Enter task number to delete:"
    read task_number

    # Move task from undone to deleted
    sed -n "${task_number}p" $UNDONE_FILE >> $DELETED_FILE
    sed -i "${task_number}d" $UNDONE_FILE
    echo "Task deleted and moved to the deleted tasks list."
}

# Function to show deleted tasks
show_deleted() {
    echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo "Deleted tasks:"
    cat $DELETED_FILE
}

# Function to search for a task in a specific list
search_task() {
    echo "Enter search term:"
    read search_term

    echo "Choose the list to search:"
    echo "1. Undone tasks"
    echo "2. Completed tasks"
    echo "3. Deleted tasks"

    read list_choice

    case $list_choice in
        1) echo "Searching for '$search_term' in Undone tasks:"
           grep -i "$search_term" $UNDONE_FILE && echo "Found in Undone tasks." ;;
        2) echo "Searching for '$search_term' in Completed tasks:"
           grep -i "$search_term" $DONE_FILE && echo "Found in Completed tasks." ;;
        3) echo "Searching for '$search_term' in Deleted tasks:"
           grep -i "$search_term" $DELETED_FILE && echo "Found in Deleted tasks." ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
}


# Main loop
while :
do
    echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    echo "Menu:"
    echo "1. Add new task"
    echo "2. Show undone tasks"
    echo "3. Mark a task as done"
    echo "4. Show completed tasks"
    echo "5. Delete a task"
    echo "6. Show deleted tasks"
    echo "7. Search for a task"
    echo "8. Quit"

    read choice

    case $choice in
        1) add_task ;;
        2) show_undone ;;
        3) mark_done ;;
        4) show_done ;;
        5) delete_task ;;
        6) show_deleted ;;
        7) search_task ;;
        8) echo "Exiting program."
           figlet GOOD BYE
           echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
           exit 0 ;;
        *) echo "Invalid choice. Please try again." ;;
    esac
done

