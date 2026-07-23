---
title: php
---


{% capture template %}



<div class="section">
    <h1>php</h1>
    <p>
        This page displays the aggregate information about the target as collected from the evaluation.
    </p>

    <div class="row">
        <div class="col s8 offset-s2">
            <img style="display: block; margin: auto;" src="../plot/survival_legend.svg">
        </div>
    </div>

    
    <h2>exif</h2>
    
        
    <h3>PHP002</h3>
    <div class="row">
        <div class="col s8 offset-s2">
            <img class="materialboxed responsive-img" src="../plot/survival_php_exif_PHP002.svg">
        </div>
    </div>
    
        
    <h3>PHP003</h3>
    <div class="row">
        <div class="col s8 offset-s2">
            <img class="materialboxed responsive-img" src="../plot/survival_php_exif_PHP003.svg">
        </div>
    </div>
    
        
    <h3>PHP004</h3>
    <div class="row">
        <div class="col s8 offset-s2">
            <img class="materialboxed responsive-img" src="../plot/survival_php_exif_PHP004.svg">
        </div>
    </div>
    
        
    <h3>PHP009</h3>
    <div class="row">
        <div class="col s8 offset-s2">
            <img class="materialboxed responsive-img" src="../plot/survival_php_exif_PHP009.svg">
        </div>
    </div>
    
        
    <h3>PHP011</h3>
    <div class="row">
        <div class="col s8 offset-s2">
            <img class="materialboxed responsive-img" src="../plot/survival_php_exif_PHP011.svg">
        </div>
    </div>
    

</div>



{% endcapture %}
{{ template | replace: '    ', ''}}
