<!DOCTYPE html>
<html>
    <head>
        <!-- Title -->
        <title>ManageVehicles</title>

        <!-- Meta Tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">

        <!-- Component Styles -->  
        <link rel="stylesheet" href="{{ asset('css/component/account-nav.css') }}">         <!--nav-->
        <link rel="stylesheet" href="{{ asset('css/component/alert.css') }}">               <!--alert-->
        <link rel="stylesheet" href="{{ asset('css/component/list-add.css') }}">            <!--manage-vehicles-add-->
        <link rel="stylesheet" href="{{ asset('css/component/list-show.css') }}">           <!--manage-vehicles-list-->
        <link rel="stylesheet" href="{{ asset('css/component/footer.css') }}">              <!--'footer'-->
        
        <!-- WebPage Styles -->
        <link rel="stylesheet" href="{{ asset('css/page.css') }}">

        @livewireStyles
    </head> 

    <body>
        @livewire('nav')
        @livewire('alert')
        <div class="title">Správa vozidiel</div>
        <div class="component-container">
            <div class="component-item">
                <label class="label">• Pridať nové vozidlo</label>
                <div class="component">@livewire('manage-vehicles-add')</div>
            </div>

            <div class="component-item-large">
                <label class="label">• Zoznam vozidiel</label>
                <div class="component">@livewire('manage-vehicles-list')</div>
            </div>
        </div>
        @livewire('footer')
        @livewire('timeout')
        @livewireScripts
    </body>
</html> 