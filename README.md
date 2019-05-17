

# Food Commercial Architecture - Architecture as Code

> Repository consisting of architectural diagrams generated through plantuml 
Food commercial architecture repository for Architecture as Code

## Why architecture-as-code?

* **Uneditable modelling artefacts**: It is common to see architecture and modelling artefacts published as images. When these artefacts are inherited or handed over, the original source from which these models were prepared are usually not available.

* **Version control not enabled**: Even when models are available in original format, the edits to those models can not be version controlled to track the history and the reasons for changes to models.

* **Expensive drawing tools required even for simple tasks:** Architecture and modelling drawings require expensive tools such as Graffle or Visual Studio even for simple drawings.

* **Difficult to colloborate:** Collobarative exercise among a pool of people is difficult while working with drawings produced from package tools.

Architecture-as-Code addressses the above issues, providing:

* Script based approach to develop architecture artefacts. Faster time to market
* Text based scripts enable version control
* The scripts can then be published into github 
* Github allows for smoother colloboration and publishing of models

## Set-up required

### Plantuml

PlantUML requires: 

* java
* [plantuml.jar](http://plantuml.com/download)
* [Graphviz is optional. Required for sequence diagrams and activity diagrams](http://plantuml.com/graphviz-dot)

### Editor and renderer

* [Visual studio code](https://code.visualstudio.com/) is the preferred editor to edit code related 
* [VS Code PlantUML Renderer Extension](https://marketplace.visualstudio.com/items?itemName=jebbs.plantuml) is a VS Code marketplace extension to render diagrams from within VS Code

### Github

* [Getting github access](https://sainsburys-confluence.valiantys.net/display/DC/GitHub#GitHub-GettingAccess) Register with github and get access from Pedro