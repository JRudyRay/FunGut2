import os
from ipywidgets import Dropdown, Output
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
