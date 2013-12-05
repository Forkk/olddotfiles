# Custom screen class for my second monitor.
# This class allows a screen to have a "primary group".
# This means that when another screen switches to this screen's group and then to some other group, 
# this screen will switch back to its primary group.

from libqtile import hook
from libqtile.config import Screen

# Prevent switching to a group owned by another screen.
class CustomScreen(Screen):
    def setGroup(self, new_group):
        """
        Put group on this screen
        """
        if new_group.screen == self:
            return

        if not new_group.screen is None:
            return

        self.previous_group = self.group

        if new_group is None:
            return

        if new_group.screen:
            # g1 <-> s1 (self)
            # g2 (new_group) <-> s2 to
            # g1 <-> s2
            # g2 <-> s1
            g1 = self.group
            s1 = self
            g2 = new_group
            s2 = new_group.screen

            s2.group = g1
            g1._setScreen(s2)
            s1.group = g2
            g2._setScreen(s1)
        else:
            old_group = self.group
            self.group = new_group

            # display clients of the new group and then hide from old group
            # to remove the screen flickering
            new_group._setScreen(self)

            if old_group is not None:
                old_group._setScreen(None)

        hook.fire("setgroup")
        hook.fire("focus_change")
        hook.fire(
            "layout_change",
            self.group.layouts[self.group.currentLayout],
            self.group
        )

