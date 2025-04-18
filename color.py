import tkinter as tk

# Define your colors (same as your Flutter AppColors)
colors = {
    "Primary": "#FF6B6B",
    "Secondary": "#4ECDC4",
    "Black": "#2D3436",
    "Dark Grey": "#636E72",
    "Grey": "#B2BEC3",
    "Light Grey": "#DFE6E9",
    "White": "#FFFFFF",
    "Success": "#00B894",
    "Warning": "#FDAA5D",
    "Error": "#FF7675",
    "Info": "#74B9FF",
    "Background": "#F8F9FA",
    "Surface": "#FFFFFF",
    "Text Primary": "#2D3436",
    "Text Secondary": "#636E72",
    "Text Hint": "#B2BEC3",
    "Border": "#DFE6E9",
    "Divider": "#EEEEEE"
}

# Create the main window
root = tk.Tk()
root.title("App Color Palette")

# Create a frame for scrollable content
canvas = tk.Canvas(root)
scrollbar = tk.Scrollbar(root, orient="vertical", command=canvas.yview)
scroll_frame = tk.Frame(canvas)

scroll_frame.bind(
    "<Configure>",
    lambda e: canvas.configure(
        scrollregion=canvas.bbox("all")
    )
)

canvas.create_window((0, 0), window=scroll_frame, anchor="nw")
canvas.configure(yscrollcommand=scrollbar.set)

# Add color swatches
for name, hex_code in colors.items():
    frame = tk.Frame(scroll_frame, bg=hex_code, height=40, width=200)
    frame.pack_propagate(False)  # Prevent children from resizing the frame
    label = tk.Label(frame, text=f"{name}: {hex_code}", bg=hex_code)
    label.config(fg="black" if hex_code != "#2D3436" else "white")
    label.pack(fill="both", expand=True)
    frame.pack(pady=5, padx=10)

# Pack and start the GUI
canvas.pack(side="left", fill="both", expand=True)
scrollbar.pack(side="right", fill="y")
root.mainloop()
