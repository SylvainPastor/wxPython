#!/usr/bin/python
# -*- coding: utf-8 -*-

import wx

class SimpleFrame(wx.Frame):
  
    def __init__(self, parent, title):
        super(SimpleFrame, self).__init__(parent, title=title, 
            size=(300, 200))
            
        self.Centre()
        self.Show()

if __name__ == '__main__':
  
    app = wx.App()
    SimpleFrame(None, title='Hello test')
    app.MainLoop()
