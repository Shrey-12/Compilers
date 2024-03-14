import tkinter as tk
from tkinter import messagebox
import mariadb
import subprocess

def connect_to_mariadb():
    try:
        conn = mariadb.connect(
            user="shreya",
            password="shreya123",
            host="localhost",
            port=3306,
            database="test"
        )
        print("Successfully connected")
        return conn
    except mariadb.Error as e:
        print(f"Error connecting to MariaDB: {e}")
        return None
    
def run_query(sql_query):
    conn = connect_to_mariadb()
    if conn:
        try:
            cursor = conn.cursor()
            cursor.execute(sql_query)
            conn.commit()
            # Fetch results (if SELECT)
            if sql_query.strip().upper().startswith("SELECT"):
                results = cursor.fetchall()
                output_text.delete("1.0", "end-1c")
                for row in results:
                    output_text.insert("end", str(row) + "\n")
            else:
                output_text.insert("end", "Query executed successfully.\n")

        except mariadb.Error as e:
            output_text.insert("end", f"Error executing query: {e}\n")
        finally:
            conn.close()

def execute_and_display_result():
    query_input = query_entry.get("1.0", "end-1c")  

    process = subprocess.Popen(['./eng2sql'], stdin=subprocess.PIPE, stdout=subprocess.PIPE)
    sql_query, err = process.communicate(input=query_input.encode())
    print(sql_query.decode().strip())

    if err:
        output_text.insert("end", f"Parser Error: {err.decode()}\n")
    else:
        sql_query = sql_query.decode().strip()
        run_query(sql_query)
        print("query ran")

def on_exit():
    if messagebox.askokcancel("Exit", "Are you sure you want to exit?"):
        root.destroy()

# GUI Setup
root = tk.Tk()
root.title("SQL GUI Application")

# Set background color of the entire application
root.configure(bg="#c4ceb5")

# Top bar with exit button
top_bar = tk.Frame(root, bg="#434822", height=30)
top_bar.pack(fill="x", side="top")

exit_button = tk.Button(top_bar, text="X", command=on_exit, bg="#434822", fg="white", font=("Arial", 10, "bold"))
exit_button.pack(side="right", padx=5)

# Frame for input and output
input_output_frame = tk.Frame(root, bg="#c4ceb5")
input_output_frame.pack(pady=20, padx=5)

# Input frame
input_frame = tk.Frame(input_output_frame, bg="#c4ceb5")
input_frame.pack(side="left", padx=5)

query_label = tk.Label(input_frame, text="Enter English Query:", bg="#c4ceb5")
query_label.pack(side="left", padx=5)

query_entry = tk.Text(input_frame, width=40, height=5)
query_entry.pack(side="left", padx=5)

# Output frame
output_frame = tk.Frame(input_output_frame, bg="#c4ceb5")
output_frame.pack(side="left", padx=5)

# Frame for buttons
button_frame = tk.Frame(root, bg="#c4ceb5")
button_frame.pack(pady=10)

run_button = tk.Button(button_frame, text="Run Query", command=execute_and_display_result, bg="#585D37", fg="white")
run_button.pack(side="left", padx=5)

# Output text
output_text = tk.Text(output_frame, width=50, height=10)
output_text.pack(pady=10)

root.protocol("WM_DELETE_WINDOW", on_exit)
root.mainloop()

# Please update the cpi of the students having roll 111 to 8.9.
# Please give me all information of students.
