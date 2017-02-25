.. _content-tabs:

Content tabs
------------

.. rst:directive:: .. content-tabs:: class

or:

.. rst:directive:: .. container:: content-tabs class

Creates block with content tabs. The same attribute `class` in several
blocks allows you to synchronize switching tabs.

If you specify a class of :ref:`right-col <column-content>` then the menu
will be fixed in the upper right position, see :ref:`example-all`.

.. rst:directive:: .. tab-container:: name

Creates content tab. Tab caption set in `title` option. The name attribute
must match the name tab of another block if you want to synchronize them.

Full example::

    .. content-tabs::

        .. tab-container:: tab1
            :title: Tab title one

            Content for tab one

        .. tab-container:: tab2
            :title: Tab title two

            Content for tab two


It's render this:

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

            my-api.signin()

        .. rubric:: Example request

        .. code-block:: python

            import my-api
            my-api.signin('username', 'password')


    .. tab-container:: php
        :title: PHP

        .. rubric:: Definition

        .. code-block:: php

            MyApi::signin();

        .. rubric:: Example request

        .. code-block:: php

            include 'my-api';
            MyApi::signin('username', 'password');
