namespace :db do
  desc "Adds feeds to database -- currently adds all arXiv feeds"
  task add_feeds: :environment do

    add_feed "astro-ph.CO", "http://export.arxiv.org/rss/astro-ph.CO", "arxiv"
    add_feed "astro-ph.EP", "http://export.arxiv.org/rss/astro-ph.EP", "arxiv"
    add_feed "astro-ph.GA", "http://export.arxiv.org/rss/astro-ph.GA", "arxiv"
    add_feed "astro-ph.HE", "http://export.arxiv.org/rss/astro-ph.HE", "arxiv"
    add_feed "astro-ph.IM", "http://export.arxiv.org/rss/astro-ph.IM", "arxiv"
    add_feed "astro-ph.SR", "http://export.arxiv.org/rss/astro-ph.SR", "arxiv"
    add_feed "cond-mat.dis-nn", "http://export.arxiv.org/rss/cond-mat.dis-nn", "arxiv"
    add_feed "cond-mat.mtrl-sci", "http://export.arxiv.org/rss/cond-mat.mtrl-sci", "arxiv"
    add_feed "cond-mat.mes-hall", "http://export.arxiv.org/rss/cond-mat.mes-hall", "arxiv"
    add_feed "cond-mat.other", "http://export.arxiv.org/rss/cond-mat.other", "arxiv"
    add_feed "cond-mat.quant-gas", "http://export.arxiv.org/rss/cond-mat.quant-gas", "arxiv"
    add_feed "cond-mat.soft", "http://export.arxiv.org/rss/cond-mat.soft", "arxiv"
    add_feed "cond-mat.stat-mech", "http://export.arxiv.org/rss/cond-mat.stat-mech", "arxiv"
    add_feed "cond-mat.str-el", "http://export.arxiv.org/rss/cond-mat.str-el", "arxiv"
    add_feed "cond-mat.supr-con", "http://export.arxiv.org/rss/cond-mat.supr-con", "arxiv"
    add_feed "gr-qc", "http://export.arxiv.org/rss/gr-qc", "arxiv"
    add_feed "hep-ex", "http://export.arxiv.org/rss/hep-ex", "arxiv"
    add_feed "hep-lat", "http://export.arxiv.org/rss/hep-lat", "arxiv"
    add_feed "hep-ph", "http://export.arxiv.org/rss/hep-ph", "arxiv"
    add_feed "hep-th", "http://export.arxiv.org/rss/hep-th", "arxiv"
    add_feed "math-ph", "http://export.arxiv.org/rss/math-ph", "arxiv"
    add_feed "nucl-ex", "http://export.arxiv.org/rss/nucl-ex", "arxiv"
    add_feed "nucl-th", "http://export.arxiv.org/rss/nucl-th", "arxiv"
    add_feed "physics.acc-ph", "http://export.arxiv.org/rss/physics.acc-ph", "arxiv"
    add_feed "physics.ao-ph", "http://export.arxiv.org/rss/physics.ao-ph", "arxiv"
    add_feed "physics.atom-ph", "http://export.arxiv.org/rss/physics.atom-ph", "arxiv"
    add_feed "physics.atm-clus", "http://export.arxiv.org/rss/physics.atm-clus", "arxiv"
    add_feed "physics.bio-ph", "http://export.arxiv.org/rss/physics.bio-ph", "arxiv"
    add_feed "physics.chem-ph", "http://export.arxiv.org/rss/physics.chem-ph", "arxiv"
    add_feed "physics.class-ph", "http://export.arxiv.org/rss/physics.class-ph", "arxiv"
    add_feed "physics.comp-ph", "http://export.arxiv.org/rss/physics.comp-ph", "arxiv"
    add_feed "physics.data-an", "http://export.arxiv.org/rss/physics.data-an", "arxiv"
    add_feed "physics.flu-dyn", "http://export.arxiv.org/rss/physics.flu-dyn", "arxiv"
    add_feed "physics.gen-ph", "http://export.arxiv.org/rss/physics.gen-ph", "arxiv"
    add_feed "physics.geo-ph", "http://export.arxiv.org/rss/physics.geo-ph", "arxiv"
    add_feed "physics.hist-ph", "http://export.arxiv.org/rss/physics.hist-ph", "arxiv"
    add_feed "physics.ins-det", "http://export.arxiv.org/rss/physics.ins-det", "arxiv"
    add_feed "physics.med-ph", "http://export.arxiv.org/rss/physics.med-ph", "arxiv"
    add_feed "physics.optics", "http://export.arxiv.org/rss/physics.optics", "arxiv"
    add_feed "physics.ed-ph", "http://export.arxiv.org/rss/physics.ed-ph", "arxiv"
    add_feed "physics.soc-ph", "http://export.arxiv.org/rss/physics.soc-ph", "arxiv"
    add_feed "physics.plasm-ph", "http://export.arxiv.org/rss/physics.plasm-ph", "arxiv"
    add_feed "physics.pop-ph", "http://export.arxiv.org/rss/physics.pop-ph", "arxiv"
    add_feed "physics.space-ph", "http://export.arxiv.org/rss/physics.space-ph", "arxiv"
    add_feed "quant-ph", "http://export.arxiv.org/rss/quant-ph", "arxiv"
    add_feed "math.AG", "http://export.arxiv.org/rss/math.AG", "arxiv"
    add_feed "math.AT", "http://export.arxiv.org/rss/math.AT", "arxiv"
    add_feed "math.AP", "http://export.arxiv.org/rss/math.AP", "arxiv"
    add_feed "math.CT", "http://export.arxiv.org/rss/math.CT", "arxiv"
    add_feed "math.CA", "http://export.arxiv.org/rss/math.CA", "arxiv"
    add_feed "math.CO", "http://export.arxiv.org/rss/math.CO", "arxiv"
    add_feed "math.AC", "http://export.arxiv.org/rss/math.AC", "arxiv"
    add_feed "math.CV", "http://export.arxiv.org/rss/math.CV", "arxiv"
    add_feed "math.DG", "http://export.arxiv.org/rss/math.DG", "arxiv"
    add_feed "math.DS", "http://export.arxiv.org/rss/math.DS", "arxiv"
    add_feed "math.FA", "http://export.arxiv.org/rss/math.FA", "arxiv"
    add_feed "math.GM", "http://export.arxiv.org/rss/math.GM", "arxiv"
    add_feed "math.GN", "http://export.arxiv.org/rss/math.GN", "arxiv"
    add_feed "math.GT", "http://export.arxiv.org/rss/math.GT", "arxiv"
    add_feed "math.GR", "http://export.arxiv.org/rss/math.GR", "arxiv"
    add_feed "math.HO", "http://export.arxiv.org/rss/math.HO", "arxiv"
    add_feed "math.IT", "http://export.arxiv.org/rss/math.IT", "arxiv"
    add_feed "math.KT", "http://export.arxiv.org/rss/math.KT", "arxiv"
    add_feed "math.LO", "http://export.arxiv.org/rss/math.LO", "arxiv"
    add_feed "math.MP", "http://export.arxiv.org/rss/math.MP", "arxiv"
    add_feed "math.MG", "http://export.arxiv.org/rss/math.MG", "arxiv"
    add_feed "math.NT", "http://export.arxiv.org/rss/math.NT", "arxiv"
    add_feed "math.NA", "http://export.arxiv.org/rss/math.NA", "arxiv"
    add_feed "math.OA", "http://export.arxiv.org/rss/math.OA", "arxiv"
    add_feed "math.OC", "http://export.arxiv.org/rss/math.OC", "arxiv"
    add_feed "math.PR", "http://export.arxiv.org/rss/math.PR", "arxiv"
    add_feed "math.QA", "http://export.arxiv.org/rss/math.QA", "arxiv"
    add_feed "math.RT", "http://export.arxiv.org/rss/math.RT", "arxiv"
    add_feed "math.RA", "http://export.arxiv.org/rss/math.RA", "arxiv"
    add_feed "math.SP", "http://export.arxiv.org/rss/math.SP", "arxiv"
    add_feed "math.ST", "http://export.arxiv.org/rss/math.ST", "arxiv"
    add_feed "math.SG", "http://export.arxiv.org/rss/math.SG", "arxiv"
    add_feed "nlin.AO", "http://export.arxiv.org/rss/nlin.AO", "arxiv"
    add_feed "nlin.CG", "http://export.arxiv.org/rss/nlin.CG", "arxiv"
    add_feed "nlin.CD", "http://export.arxiv.org/rss/nlin.CD", "arxiv"
    add_feed "nlin.SI", "http://export.arxiv.org/rss/nlin.SI", "arxiv"
    add_feed "nlin.PS", "http://export.arxiv.org/rss/nlin.PS", "arxiv"
    add_feed "cs.AI", "http://export.arxiv.org/rss/cs.AI", "arxiv"
    add_feed "cs.CL", "http://export.arxiv.org/rss/cs.CL", "arxiv"
    add_feed "cs.CC", "http://export.arxiv.org/rss/cs.CC", "arxiv"
    add_feed "cs.CE", "http://export.arxiv.org/rss/cs.CE", "arxiv"
    add_feed "cs.CG", "http://export.arxiv.org/rss/cs.CG", "arxiv"
    add_feed "cs.GT", "http://export.arxiv.org/rss/cs.GT", "arxiv"
    add_feed "cs.CV", "http://export.arxiv.org/rss/cs.CV", "arxiv"
    add_feed "cs.CY", "http://export.arxiv.org/rss/cs.CY", "arxiv"
    add_feed "cs.CR", "http://export.arxiv.org/rss/cs.CR", "arxiv"
    add_feed "cs.DS", "http://export.arxiv.org/rss/cs.DS", "arxiv"
    add_feed "cs.DB", "http://export.arxiv.org/rss/cs.DB", "arxiv"
    add_feed "cs.DL", "http://export.arxiv.org/rss/cs.DL", "arxiv"
    add_feed "cs.DM", "http://export.arxiv.org/rss/cs.DM", "arxiv"
    add_feed "cs.DC", "http://export.arxiv.org/rss/cs.DC", "arxiv"
    add_feed "cs.ET", "http://export.arxiv.org/rss/cs.ET", "arxiv"
    add_feed "cs.FL", "http://export.arxiv.org/rss/cs.FL", "arxiv"
    add_feed "cs.GL", "http://export.arxiv.org/rss/cs.GL", "arxiv"
    add_feed "cs.GR", "http://export.arxiv.org/rss/cs.GR", "arxiv"
    add_feed "cs.AR", "http://export.arxiv.org/rss/cs.AR", "arxiv"
    add_feed "cs.HC", "http://export.arxiv.org/rss/cs.HC", "arxiv"
    add_feed "cs.IR", "http://export.arxiv.org/rss/cs.IR", "arxiv"
    add_feed "cs.IT", "http://export.arxiv.org/rss/cs.IT", "arxiv"
    add_feed "cs.LG", "http://export.arxiv.org/rss/cs.LG", "arxiv"
    add_feed "cs.LO", "http://export.arxiv.org/rss/cs.LO", "arxiv"
    add_feed "cs.MS", "http://export.arxiv.org/rss/cs.MS", "arxiv"
    add_feed "cs.MA", "http://export.arxiv.org/rss/cs.MA", "arxiv"
    add_feed "cs.MM", "http://export.arxiv.org/rss/cs.MM", "arxiv"
    add_feed "cs.NI", "http://export.arxiv.org/rss/cs.NI", "arxiv"
    add_feed "cs.NE", "http://export.arxiv.org/rss/cs.NE", "arxiv"
    add_feed "cs.NA", "http://export.arxiv.org/rss/cs.NA", "arxiv"
    add_feed "cs.OS", "http://export.arxiv.org/rss/cs.OS", "arxiv"
    add_feed "cs.OH", "http://export.arxiv.org/rss/cs.OH", "arxiv"
    add_feed "cs.PF", "http://export.arxiv.org/rss/cs.PF", "arxiv"
    add_feed "cs.PL", "http://export.arxiv.org/rss/cs.PL", "arxiv"
    add_feed "cs.RO", "http://export.arxiv.org/rss/cs.RO", "arxiv"
    add_feed "cs.SI", "http://export.arxiv.org/rss/cs.SI", "arxiv"
    add_feed "cs.SE", "http://export.arxiv.org/rss/cs.SE", "arxiv"
    add_feed "cs.SD", "http://export.arxiv.org/rss/cs.SD", "arxiv"
    add_feed "cs.SC", "http://export.arxiv.org/rss/cs.SC", "arxiv"
    add_feed "cs.SY", "http://export.arxiv.org/rss/cs.SY", "arxiv"
    add_feed "q-bio.BM", "http://export.arxiv.org/rss/q-bio.BM", "arxiv"
    add_feed "q-bio.CB", "http://export.arxiv.org/rss/q-bio.CB", "arxiv"
    add_feed "q-bio.GN", "http://export.arxiv.org/rss/q-bio.GN", "arxiv"
    add_feed "q-bio.MN", "http://export.arxiv.org/rss/q-bio.MN", "arxiv"
    add_feed "q-bio.NC", "http://export.arxiv.org/rss/q-bio.NC", "arxiv"
    add_feed "q-bio.OT", "http://export.arxiv.org/rss/q-bio.OT", "arxiv"
    add_feed "q-bio.PE", "http://export.arxiv.org/rss/q-bio.PE", "arxiv"
    add_feed "q-bio.QM", "http://export.arxiv.org/rss/q-bio.QM", "arxiv"
    add_feed "q-bio.SC", "http://export.arxiv.org/rss/q-bio.SC", "arxiv"
    add_feed "q-bio.TO", "http://export.arxiv.org/rss/q-bio.TO", "arxiv"
    add_feed "q-fin.CP", "http://export.arxiv.org/rss/q-fin.CP", "arxiv"
    add_feed "q-fin.GN", "http://export.arxiv.org/rss/q-fin.GN", "arxiv"
    add_feed "q-fin.PM", "http://export.arxiv.org/rss/q-fin.PM", "arxiv"
    add_feed "q-fin.PR", "http://export.arxiv.org/rss/q-fin.PR", "arxiv"
    add_feed "q-fin.RM", "http://export.arxiv.org/rss/q-fin.RM", "arxiv"
    add_feed "q-fin.ST", "http://export.arxiv.org/rss/q-fin.ST", "arxiv"
    add_feed "q-fin.TR", "http://export.arxiv.org/rss/q-fin.TR", "arxiv"
    add_feed "stat.AP", "http://export.arxiv.org/rss/stat.AP", "arxiv"
    add_feed "stat.CO", "http://export.arxiv.org/rss/stat.CO", "arxiv"
    add_feed "stat.ML", "http://export.arxiv.org/rss/stat.ML", "arxiv"
    add_feed "stat.ME", "http://export.arxiv.org/rss/stat.ME", "arxiv"
    add_feed "stat.OT", "http://export.arxiv.org/rss/stat.OT", "arxiv"
    add_feed "stat.TH", "http://export.arxiv.org/rss/stat.TH", "arxiv"

  end
end

# Creates a new feed only if it does not already exist
def add_feed name, url, type
  if Feed.find_by_name(name).nil?
    Feed.create(name: name, url: url, feed_type: type, updated_date: Date.yesterday)
  end
end
