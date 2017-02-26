.. _content-tabs:

Content tabs
------------

.. rst:directive:: .. content-tabs:: class

or:

.. rst:directive:: .. container:: content-tabs class

"content-tabs" directive creates a block with content tabs.
Content of only one tab will be shown at the same time.
Content switches with click on corresponding tab's caption.
Click on caption of `tab-container`'s caption with the same `name` attribute
activates all tabs with the same `name` in all `content-tab` blocks with the same
attribute `class`.

Special class :ref:`right-col <column-content>` fixates the "content-tabs"
menu in the upper right position, see :ref:`example-all`.

.. rst:directive:: .. tab-container:: name

"tab-container" directive creates a content tab. Tab's caption is set by
`title` option. To switch tabs synchronously the `name` attribute should match
with "tab-container" from another blocks.

Full example::

    .. content-tabs::

        .. tab-container:: tab1
            :title: Tab title one

            Content for tab one

        .. tab-container:: tab2
            :title: Tab title two

            Content for tab two


will be rendered like this:

.. content-tabs::

    .. tab-container:: tab1
        :title: Tab title one

        Content for tab one

    .. tab-container:: tab2
        :title: Tab title two

        Content for tab two

Generated HTML code:

.. code-block:: html

    <div class="content-tabs docutils container">
        <ul class="contenttab-selector">
            <li class="tab-tab1 selected">Tab title one</li>
            <li class="tab-tab2">Tab title two</li>
        </ul>
        <div class="tab-content docutils container contenttab" id="tab-tab1">
            <p>Content for tab one</p>
        </div>
        <div class="tab-content docutils container contenttab" id="tab-tab2" style="display: none;">
            <p>Content for tab two</p>
        </div>
    </div>

More examples
~~~~~~~~~~~~~

.. content-tabs::

    .. tab-container:: python
        :title: Python

        .. rubric:: Definition

        .. code-block:: python

            my_api.signin()

        .. rubric:: Example request

        .. code-block:: python

            import my_api
            my_api.signin('username', 'password')


    .. tab-container:: php
        :title: PHP

        .. rubric:: Definition

        .. code-block:: php

            MyApi::signin();

        .. rubric:: Example request

        .. code-block:: php

            include 'my-api.php';
            MyApi::signin('username', 'password');
