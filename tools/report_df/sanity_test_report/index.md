---
title: Report
---


{% capture template %}



<div class="section">
    <h1>Experiment Configuration</h1>
    <ul class="browser-default">
        <li><b>Duration</b>: 604800s</li>
        <li><b>Trials</b>: 10</li>
        <li><b>Version</b>: v1.0</li>
    </ul>
</div>
<div class="section">
    <h1>Fuzz Targets</h1>
    <p>This report summarizes the results of fuzzing the following targets:</p>
    <ul id="target-list" class="browser-default">
        
        <li><a href="targets/libpng.html">libpng</a></li>
        
        <li><a href="targets/libsndfile.html">libsndfile</a></li>
        
        <li><a href="targets/libxml2.html">libxml2</a></li>
        
        <li><a href="targets/lua.html">lua</a></li>
        
        <li><a href="targets/openssl.html">openssl</a></li>
        
        <li><a href="targets/php.html">php</a></li>
        
        <li><a href="targets/poppler.html">poppler</a></li>
        
        <li><a href="targets/sqlite3.html">sqlite3</a></li>
        
    </ul>
</div>

<div class="section">
    <h1>Evaluated Fuzzers</h1>
    <p>The fuzzers used in this evaluation are listed below:</p>
    <ul id="fuzzer-list" class="browser-default">
        
        <li><a href="fuzzers/afl_entropy.html">afl_entropy</a></li>
        
    </ul>
</div>

<!--
EXPERIMENT PARAMETERS WILL BE LISTED HERE
-->

<div class="section">
    <h1>Experiment Summary</h1>
    <div id="bugs-triggered">
        <h2>Total Unique Bugs Triggered</h2>
        <ul class="collapsible popout">
            <li>
                <div class="collapsible-header">
                    <h3>Mean and Standard Deviation</h3>
                </div>
                <div class="collapsible-body">
                    This plot shows the mean number of unique bugs triggered by every fuzzer against every target,
                    and the standard deviation bar, across all campaigns.
                </div>
            </li>
        </ul>
        <img class="materialboxed responsive-img" src="plot/summary_unique_bugs.svg">
        <ul class="collapsible popout">
            <li>
                <div class="collapsible-header">
                    <h3>Stastistical Significance</h3>
                </div>
                <div class="collapsible-body">
                    This matrix summarizes the p-values of the pairwise Mann-Whitney U tests calculated against the
                    total bug count sample sets collected for every fuzzer across all campaigns. Cells with a green
                    shade indicate that the number of bugs triggered by a fuzzer is statistically different.
                </div>
            </li>
        </ul>
        <img class="materialboxed responsive-img" src="plot/summary_signplot.svg">
    </div>

    <div id="mean-survival">
        <h2>Mean Survival Time</h2>
        <ul class="collapsible popout">
            <li>
                <div class="collapsible-header">
                    <h3>Ranking of Bugs and Fuzzers</h3>
                </div>
                <div class="collapsible-body">
                    This table shows the restricted mean survival time for every bug being reached or triggered over the
                    duration of the campaign, using the Kaplan-Meier non-parametric survival function estimator.
                    Green-shaded cells indicate the best performance (lowest time) for a bug metric across all fuzzers.
                    Yellow-shaded cells indicate the worst performance (highest time) for a bug metric across all fuzzers.
                    Red-shaded cells indicate that the bug survived being reached or triggered by the fuzzer throughout
                    the campaign duration.
                </div>
            </li>
        </ul>
        <div class="center">
            <a id="btn-colormap" class="btn-small waves-effect waves-light" style="margin-bottom: 10px; color: white; font-weight: normal;">
                <i class="material-icons left">color_lens</i>
                Change Colormap
            </a>
        </div>
        <script type="text/javascript">
            $('#btn-colormap').click(function() {
                stl = $('#survival_stylesheet');
                var href = stl.prop('href');
                if (href.includes('hiliter')) {
                    stl.prop('href', 'css/survival_heatmap.css');
                } else {
                    stl.prop('href', 'css/survival_hiliter.css');
                }
            });
        </script>
        <link id="survival_stylesheet" rel="stylesheet" href="css/survival_hiliter.css">
        <table id="T_survival_table" ><thead>    <tr>        <th class="index_name level0" >Fuzzer</th>        <th class="col_heading level0 col0" colspan="2">afl_entropy</th>    </tr>    <tr>        <th class="index_name level1" >Metric</th>        <th class="col_heading level1 col0" >R</th>        <th class="col_heading level1 col1" >T</th>    </tr>    <tr>        <th class="index_name level0" >Bug ID</th>        <th class="blank" ></th>        <th class="blank" ></th>    </tr></thead><tbody>
                <tr>
                        <th id="T_survival_tablelevel0_row0" class="row_heading level0 row0" >PNG003</th>
                        <td id="T_survival_tablerow0_col0" class="data row0 col0" >10s</td>
                        <td id="T_survival_tablerow0_col1" class="data row0 col1" >15s</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row1" class="row_heading level0 row1" >PDF016</th>
                        <td id="T_survival_tablerow1_col0" class="data row1 col0" >10s</td>
                        <td id="T_survival_tablerow1_col1" class="data row1 col1" >40s</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row2" class="row_heading level0 row2" >XML017</th>
                        <td id="T_survival_tablerow2_col0" class="data row2 col0" >10s</td>
                        <td id="T_survival_tablerow2_col1" class="data row2 col1" >1m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row3" class="row_heading level0 row3" >PNG006</th>
                        <td id="T_survival_tablerow3_col0" class="data row3 col0" >15s</td>
                        <td id="T_survival_tablerow3_col1" class="data row3 col1" >1m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row4" class="row_heading level0 row4" >SSL003</th>
                        <td id="T_survival_tablerow4_col0" class="data row4 col0" >10s</td>
                        <td id="T_survival_tablerow4_col1" class="data row4 col1" >7m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row5" class="row_heading level0 row5" >PHP011</th>
                        <td id="T_survival_tablerow5_col0" class="data row5 col0" >10s</td>
                        <td id="T_survival_tablerow5_col1" class="data row5 col1" >7m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row6" class="row_heading level0 row6" >SSL002</th>
                        <td id="T_survival_tablerow6_col0" class="data row6 col0" >15s</td>
                        <td id="T_survival_tablerow6_col1" class="data row6 col1" >8m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row7" class="row_heading level0 row7" >SND024</th>
                        <td id="T_survival_tablerow7_col0" class="data row7 col0" >15s</td>
                        <td id="T_survival_tablerow7_col1" class="data row7 col1" >8m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row8" class="row_heading level0 row8" >SND006</th>
                        <td id="T_survival_tablerow8_col0" class="data row8 col0" >15s</td>
                        <td id="T_survival_tablerow8_col1" class="data row8 col1" >8m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row9" class="row_heading level0 row9" >SND007</th>
                        <td id="T_survival_tablerow9_col0" class="data row9 col0" >15s</td>
                        <td id="T_survival_tablerow9_col1" class="data row9 col1" >8m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row10" class="row_heading level0 row10" >SND001</th>
                        <td id="T_survival_tablerow10_col0" class="data row10 col0" >15s</td>
                        <td id="T_survival_tablerow10_col1" class="data row10 col1" >20m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row11" class="row_heading level0 row11" >XML009</th>
                        <td id="T_survival_tablerow11_col0" class="data row11 col0" >15s</td>
                        <td id="T_survival_tablerow11_col1" class="data row11 col1" >29m</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row12" class="row_heading level0 row12" >SQL002</th>
                        <td id="T_survival_tablerow12_col0" class="data row12 col0" >1m</td>
                        <td id="T_survival_tablerow12_col1" class="data row12 col1" >1h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row13" class="row_heading level0 row13" >SND005</th>
                        <td id="T_survival_tablerow13_col0" class="data row13 col0" >10s</td>
                        <td id="T_survival_tablerow13_col1" class="data row13 col1" >1h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row14" class="row_heading level0 row14" >SQL014</th>
                        <td id="T_survival_tablerow14_col0" class="data row14 col0" >29m</td>
                        <td id="T_survival_tablerow14_col1" class="data row14 col1" >1h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row15" class="row_heading level0 row15" >SSL001</th>
                        <td id="T_survival_tablerow15_col0" class="data row15 col0" >20s</td>
                        <td id="T_survival_tablerow15_col1" class="data row15 col1" >1h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row16" class="row_heading level0 row16" >XML002</th>
                        <td id="T_survival_tablerow16_col0" class="data row16 col0" >2h</td>
                        <td id="T_survival_tablerow16_col1" class="data row16 col1" >2h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row17" class="row_heading level0 row17" >SQL018</th>
                        <td id="T_survival_tablerow17_col0" class="data row17 col0" >5m</td>
                        <td id="T_survival_tablerow17_col1" class="data row17 col1" >2h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row18" class="row_heading level0 row18" >SND017</th>
                        <td id="T_survival_tablerow18_col0" class="data row18 col0" >7m</td>
                        <td id="T_survival_tablerow18_col1" class="data row18 col1" >2h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row19" class="row_heading level0 row19" >PDF010</th>
                        <td id="T_survival_tablerow19_col0" class="data row19 col0" >15s</td>
                        <td id="T_survival_tablerow19_col1" class="data row19 col1" >2h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row20" class="row_heading level0 row20" >SND020</th>
                        <td id="T_survival_tablerow20_col0" class="data row20 col0" >8m</td>
                        <td id="T_survival_tablerow20_col1" class="data row20 col1" >3h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row21" class="row_heading level0 row21" >SSL020</th>
                        <td id="T_survival_tablerow21_col0" class="data row21 col0" >15s</td>
                        <td id="T_survival_tablerow21_col1" class="data row21 col1" >3h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row22" class="row_heading level0 row22" >PDF019</th>
                        <td id="T_survival_tablerow22_col0" class="data row22 col0" >35s</td>
                        <td id="T_survival_tablerow22_col1" class="data row22 col1" >4h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row23" class="row_heading level0 row23" >PHP009</th>
                        <td id="T_survival_tablerow23_col0" class="data row23 col0" >15s</td>
                        <td id="T_survival_tablerow23_col1" class="data row23 col1" >4h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row24" class="row_heading level0 row24" >LUA004</th>
                        <td id="T_survival_tablerow24_col0" class="data row24 col0" >5h</td>
                        <td id="T_survival_tablerow24_col1" class="data row24 col1" >5h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row25" class="row_heading level0 row25" >PDF003</th>
                        <td id="T_survival_tablerow25_col0" class="data row25 col0" >20s</td>
                        <td id="T_survival_tablerow25_col1" class="data row25 col1" >6h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row26" class="row_heading level0 row26" >PNG007</th>
                        <td id="T_survival_tablerow26_col0" class="data row26 col0" >15s</td>
                        <td id="T_survival_tablerow26_col1" class="data row26 col1" >7h</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row27" class="row_heading level0 row27" >PNG004</th>
                        <td id="T_survival_tablerow27_col0" class="data row27 col0" >15s</td>
                        <td id="T_survival_tablerow27_col1" class="data row27 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row28" class="row_heading level0 row28" >PDF006</th>
                        <td id="T_survival_tablerow28_col0" class="data row28 col0" >35s</td>
                        <td id="T_survival_tablerow28_col1" class="data row28 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row29" class="row_heading level0 row29" >PDF005</th>
                        <td id="T_survival_tablerow29_col0" class="data row29 col0" >1m</td>
                        <td id="T_survival_tablerow29_col1" class="data row29 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row30" class="row_heading level0 row30" >PDF004</th>
                        <td id="T_survival_tablerow30_col0" class="data row30 col0" >1h</td>
                        <td id="T_survival_tablerow30_col1" class="data row30 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row31" class="row_heading level0 row31" >SSL005</th>
                        <td id="T_survival_tablerow31_col0" class="data row31 col0" >20s</td>
                        <td id="T_survival_tablerow31_col1" class="data row31 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row32" class="row_heading level0 row32" >SSL008</th>
                        <td id="T_survival_tablerow32_col0" class="data row32 col0" >20s</td>
                        <td id="T_survival_tablerow32_col1" class="data row32 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row33" class="row_heading level0 row33" >SSL009</th>
                        <td id="T_survival_tablerow33_col0" class="data row33 col0" >20s</td>
                        <td id="T_survival_tablerow33_col1" class="data row33 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row34" class="row_heading level0 row34" >SSL010</th>
                        <td id="T_survival_tablerow34_col0" class="data row34 col0" >15s</td>
                        <td id="T_survival_tablerow34_col1" class="data row34 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row35" class="row_heading level0 row35" >SSL016</th>
                        <td id="T_survival_tablerow35_col0" class="data row35 col0" >30s</td>
                        <td id="T_survival_tablerow35_col1" class="data row35 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row36" class="row_heading level0 row36" >SSL019</th>
                        <td id="T_survival_tablerow36_col0" class="data row36 col0" >10s</td>
                        <td id="T_survival_tablerow36_col1" class="data row36 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row37" class="row_heading level0 row37" >XML001</th>
                        <td id="T_survival_tablerow37_col0" class="data row37 col0" >15s</td>
                        <td id="T_survival_tablerow37_col1" class="data row37 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row38" class="row_heading level0 row38" >PDF002</th>
                        <td id="T_survival_tablerow38_col0" class="data row38 col0" >1m</td>
                        <td id="T_survival_tablerow38_col1" class="data row38 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row39" class="row_heading level0 row39" >XML003</th>
                        <td id="T_survival_tablerow39_col0" class="data row39 col0" >15s</td>
                        <td id="T_survival_tablerow39_col1" class="data row39 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row40" class="row_heading level0 row40" >XML006</th>
                        <td id="T_survival_tablerow40_col0" class="data row40 col0" >15s</td>
                        <td id="T_survival_tablerow40_col1" class="data row40 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row41" class="row_heading level0 row41" >XML008</th>
                        <td id="T_survival_tablerow41_col0" class="data row41 col0" >35s</td>
                        <td id="T_survival_tablerow41_col1" class="data row41 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row42" class="row_heading level0 row42" >PDF001</th>
                        <td id="T_survival_tablerow42_col0" class="data row42 col0" >50s</td>
                        <td id="T_survival_tablerow42_col1" class="data row42 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row43" class="row_heading level0 row43" >XML011</th>
                        <td id="T_survival_tablerow43_col0" class="data row43 col0" >15s</td>
                        <td id="T_survival_tablerow43_col1" class="data row43 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row44" class="row_heading level0 row44" >SQL019</th>
                        <td id="T_survival_tablerow44_col0" class="data row44 col0" >4m</td>
                        <td id="T_survival_tablerow44_col1" class="data row44 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row45" class="row_heading level0 row45" >PDF007</th>
                        <td id="T_survival_tablerow45_col0" class="data row45 col0" >15s</td>
                        <td id="T_survival_tablerow45_col1" class="data row45 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row46" class="row_heading level0 row46" >SQL017</th>
                        <td id="T_survival_tablerow46_col0" class="data row46 col0" >1m</td>
                        <td id="T_survival_tablerow46_col1" class="data row46 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row47" class="row_heading level0 row47" >SQL016</th>
                        <td id="T_survival_tablerow47_col0" class="data row47 col0" >1m</td>
                        <td id="T_survival_tablerow47_col1" class="data row47 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row48" class="row_heading level0 row48" >PNG005</th>
                        <td id="T_survival_tablerow48_col0" class="data row48 col0" >15s</td>
                        <td id="T_survival_tablerow48_col1" class="data row48 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row49" class="row_heading level0 row49" >PHP004</th>
                        <td id="T_survival_tablerow49_col0" class="data row49 col0" >15s</td>
                        <td id="T_survival_tablerow49_col1" class="data row49 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row50" class="row_heading level0 row50" >PHP003</th>
                        <td id="T_survival_tablerow50_col0" class="data row50 col0" >15s</td>
                        <td id="T_survival_tablerow50_col1" class="data row50 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row51" class="row_heading level0 row51" >PHP002</th>
                        <td id="T_survival_tablerow51_col0" class="data row51 col0" >15s</td>
                        <td id="T_survival_tablerow51_col1" class="data row51 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row52" class="row_heading level0 row52" >PDF022</th>
                        <td id="T_survival_tablerow52_col0" class="data row52 col0" >45s</td>
                        <td id="T_survival_tablerow52_col1" class="data row52 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row53" class="row_heading level0 row53" >PDF021</th>
                        <td id="T_survival_tablerow53_col0" class="data row53 col0" >15s</td>
                        <td id="T_survival_tablerow53_col1" class="data row53 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row54" class="row_heading level0 row54" >XML012</th>
                        <td id="T_survival_tablerow54_col0" class="data row54 col0" >15s</td>
                        <td id="T_survival_tablerow54_col1" class="data row54 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row55" class="row_heading level0 row55" >PDF014</th>
                        <td id="T_survival_tablerow55_col0" class="data row55 col0" >35s</td>
                        <td id="T_survival_tablerow55_col1" class="data row55 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row56" class="row_heading level0 row56" >PNG001</th>
                        <td id="T_survival_tablerow56_col0" class="data row56 col0" >15s</td>
                        <td id="T_survival_tablerow56_col1" class="data row56 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row57" class="row_heading level0 row57" >PDF012</th>
                        <td id="T_survival_tablerow57_col0" class="data row57 col0" >15s</td>
                        <td id="T_survival_tablerow57_col1" class="data row57 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row58" class="row_heading level0 row58" >PDF009</th>
                        <td id="T_survival_tablerow58_col0" class="data row58 col0" >30s</td>
                        <td id="T_survival_tablerow58_col1" class="data row58 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row59" class="row_heading level0 row59" >SQL006</th>
                        <td id="T_survival_tablerow59_col0" class="data row59 col0" >7h</td>
                        <td id="T_survival_tablerow59_col1" class="data row59 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row60" class="row_heading level0 row60" >SQL007</th>
                        <td id="T_survival_tablerow60_col0" class="data row60 col0" >45s</td>
                        <td id="T_survival_tablerow60_col1" class="data row60 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row61" class="row_heading level0 row61" >SQL009</th>
                        <td id="T_survival_tablerow61_col0" class="data row61 col0" >7m</td>
                        <td id="T_survival_tablerow61_col1" class="data row61 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row62" class="row_heading level0 row62" >SQL010</th>
                        <td id="T_survival_tablerow62_col0" class="data row62 col0" >1m</td>
                        <td id="T_survival_tablerow62_col1" class="data row62 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row63" class="row_heading level0 row63" >SQL012</th>
                        <td id="T_survival_tablerow63_col0" class="data row63 col0" >3h</td>
                        <td id="T_survival_tablerow63_col1" class="data row63 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row64" class="row_heading level0 row64" >PDF008</th>
                        <td id="T_survival_tablerow64_col0" class="data row64 col0" >30s</td>
                        <td id="T_survival_tablerow64_col1" class="data row64 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row65" class="row_heading level0 row65" >SQL015</th>
                        <td id="T_survival_tablerow65_col0" class="data row65 col0" >1m</td>
                        <td id="T_survival_tablerow65_col1" class="data row65 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row66" class="row_heading level0 row66" >PDF011</th>
                        <td id="T_survival_tablerow66_col0" class="data row66 col0" >15s</td>
                        <td id="T_survival_tablerow66_col1" class="data row66 col1" >1w</td>
            </tr>
            <tr>
                        <th id="T_survival_tablelevel0_row67" class="row_heading level0 row67" >SND016</th>
                        <td id="T_survival_tablerow67_col0" class="data row67 col0" >15s</td>
                        <td id="T_survival_tablerow67_col1" class="data row67 col1" >1w</td>
            </tr>
    </tbody></table>
    </div>
</div>



{% endcapture %}
{{ template | replace: '    ', ''}}
