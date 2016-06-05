# -*- Mode: Python; coding: utf-8; indent-tabs-mode: nil; tab-width: 4 -*-
### BEGIN LICENSE
# Copyright (C) 2010 Leszek Lesner leszek@zevenos.com
# This program is free software: you can redistribute it and/or modify it 
# under the terms of the GNU General Public License version 3, as published 
# by the Free Software Foundation.
# 
# This program is distributed in the hope that it will be useful, but 
# WITHOUT ANY WARRANTY; without even the implied warranties of 
# MERCHANTABILITY, SATISFACTORY QUALITY, or FITNESS FOR A PARTICULAR 
# PURPOSE.  See the GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License along 
# with this program.  If not, see <http://www.gnu.org/licenses/>.
### END LICENSE

#from desktopcouch.records.server import CouchDatabase
#from desktopcouch.records.record import Record
import gtk, os, sys, subprocess

from lxkeymap.helpers import get_builder

import gettext
from gettext import gettext as _
gettext.textdomain('lxkeymap')

class PreferencesLxkeymapDialog(gtk.Dialog):
    __gtype_name__ = "PreferencesLxkeymapDialog"
    preferences = {}

    def __new__(cls):
        """Special static method that's automatically called by Python when 
        constructing a new instance of this class.
        
        Returns a fully instantiated PreferencesLxkeymapDialog object.
        """
        builder = get_builder('PreferencesLxkeymapDialog')
        new_object = builder.get_object("preferences_lxkeymap_dialog")
        new_object.finish_initializing(builder)
        return new_object

    def finish_initializing(self, builder):
        """Called while initializing this instance in __new__

        finish_initalizing should be called after parsing the ui definition
        and creating a PreferencesLxkeymapDialog object with it in order to
        finish initializing the start of the new PerferencesLxkeymapDialog
        instance.
        
        Put your initialization code in here and leave __init__ undefined.
        """

        # Connect signals here
        self.builder = builder
        self.builder.connect_signals(self)

        # Create a TreeStore with one string column to use as the model
        self.treestore = gtk.TreeStore(str)
        self.treestore.append(None,["Generic"])
        self.treeview_profiles = gtk.TreeView(self.treestore)
        self.column_profiles = gtk.TreeViewColumn('profiles')
        self.treeview_profiles.set_headers_visible(False)
        self.treeview_profiles.append_column(self.column_profiles)
        self.cell = gtk.CellRendererText()
        self.column_profiles.pack_start(self.cell, True)
        self.column_profiles.add_attribute(self.cell, "text", 0)
        self.treeview_profiles.set_search_column(0)
        self.scrolledwindow_profiles = builder.get_object("scrolledwindow_profiles")
        self.scrolledwindow_profiles.add(self.treeview_profiles)
        #self.treeview_profiles.connect("cursor-changed", self.on_profile_click)
        selection = self.treeview_profiles.get_selection()
        selection.select_path(0)
        self.treeview_profiles.show()


    def ok(self, widget, data=None):
        """The user has elected to save the changes.

        Called before the dialog returns gtk.RESONSE_OK from run().
        """
        # Make any updates to self._preferences here. e.g.
        #self._preferences["preference1"] = "value2"
        #self._save_preferences()
        model = self.treeview_profiles.get_model()
        selection = self.treeview_profiles.get_selection()
        (model, iter) = selection.get_selected()
        self.profile_selected = model.get_value(iter, 0)
        p=subprocess.Popen("echo '" + self.profile_selected + "' > /tmp/lxkeymap_current_profile",shell=True)
        p.communicate()

    def cancel(self, widget, data=None):
        """The user has elected cancel changes.

        Called before the dialog returns gtk.RESPONSE_CANCEL for run()
        """
        # Restore any changes to self._preferences here.
        pass

    def on_addbtn_clicked(self, widget, data=None):
        """Add a new keyboard layout profile here"""
        newSection = self.getText()
        if len(newSection) == 0:
                pass
        else:
                self.treestore.append(None,[newSection])

    def responseToDialog(self, entry, dialog, response):
        dialog.response(response)

    def getText(self):
        #base this on a message dialog
        dialog = gtk.MessageDialog(
                None,
                gtk.DIALOG_MODAL | gtk.DIALOG_DESTROY_WITH_PARENT,
                gtk.MESSAGE_QUESTION,
                gtk.BUTTONS_OK,
                None)
        dialog.set_markup('Please enter your <b>name</b>:')
        #create the text input field
        entry = gtk.Entry()
        #allow the user to press enter to do ok
        entry.connect("activate", self.responseToDialog, dialog, gtk.RESPONSE_OK)
        #create a horizontal box to pack the entry and a label
        hbox = gtk.HBox()
        hbox.pack_start(gtk.Label("Name:"), False, 5, 5)
        hbox.pack_end(entry)
        #some secondary text
        dialog.format_secondary_markup("This will be used for <i>identification</i> purposes")
        #add it and show it
        dialog.vbox.pack_end(hbox, True, True, 0)
        dialog.show_all()
        #go go go
        dialog.run()
        text = entry.get_text()
        dialog.destroy()
        return text

if __name__ == "__main__":
    dialog = PreferencesLxkeymapDialog()
    dialog.show()
    gtk.main()
