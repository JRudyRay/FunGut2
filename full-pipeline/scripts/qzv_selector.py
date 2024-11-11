import os
from ipywidgets import Dropdown, Output, VBox
from IPython.display import display
from qiime2 import Visualization

def display_qzv_selector(directory='../data/core-metrics-results'):
    def list_qzv_files(directory):
        return [f for f in os.listdir(directory) if f.endswith('.qzv') and os.path.isfile(os.path.join(directory, f))]

    qzv_files = list_qzv_files(directory)

    dropdown = Dropdown(
        options=qzv_files,
        description='Select .qzv file:',
        disabled=False,
    )

    out = Output()

    def on_file_change(change):
        with out:
            out.clear_output()
            selected_file = change["new"]
            print(f'Selected file: {selected_file}')
            visualization = Visualization.load(os.path.join(directory, selected_file))
            display(visualization)

    dropdown.observe(on_file_change, names='value')

    display(dropdown, out)

    

def create_category_selector(categories=["country", "state", "sex", "diet_type", "ibd", "gluten"]):
    # Output widget for displaying selection feedback
    out = Output()

    # Dropdown widget
    category_dropdown = Dropdown(
        options=categories,
        description='Select Category:',
        disabled=False,
    )

    # Function to handle category selection and return the selected value
    def on_category_change(change):
        with out:
            out.clear_output()
            selected_category = change["new"]
            print(f'Selected category: {selected_category}')
            return selected_category  # Return the selected category here

    # Observe changes in the dropdown
    category_dropdown.observe(on_category_change, names='value')

    # Display dropdown and output area
    display(VBox([category_dropdown, out]))

    # Return the output widget to access the selected category in the notebook
    return category_dropdown