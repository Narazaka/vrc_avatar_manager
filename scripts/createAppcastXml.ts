import {convert} from "xmlbuilder2"
import {format} from "date-fns"

export type AppcastXML = {
  rss: {
    '@version': '2.0';
    '@xmlns:sparkle': 'http://www.andymatuschak.org/xml-namespaces/sparkle';
    channel: {
      title: string;
      description?: string;
      language: string;
      item: AppcastXMLItem | AppcastXMLItem[];
    };
  };
}

export type AppcastXMLItem = {
  title: string;
  description?: string;
  'sparkle:version'?: string;
  'sparkle:shortVersionString'?: string;
  'sparkle:releaseNotesLink'?: string;
  'sparkle:minimumSystemVersion'?: string;
  'sparkle:minimumAutoupdateVersion'?: string;
  'sparkle:ignoreSkippedUpgradesBelowVersion'?: string;
  pubDate: string;
  enclosure: {
    '@url': string;
    '@sparkle:edSignature'?: string;
    '@sparkle:dsaSignature'?: string;
    '@sparkle:os': string;
    '@length': string;
    '@type': string;
  };
}

export type AppcastSetting = {
  title: string;
  description?: string;
  language: string;
}

export type AppcastItemBase = {
  version: string;
  description?: string;
  url: string;
  pubDate: Date;
  releaseNotesLink?: string;
  minimumSystemVersion?: string;
  minimumAutoupdateVersion?: string;
  ignoreSkippedUpgradesBelowVersion?: string;
  os: "windows" | "macos";
  length: number;
  edSignature?: string;
  dsaSignature?: string;
}

export type AppcastItem =
  | (AppcastItemBase & Required<Pick<AppcastItemBase, "edSignature">>)
  | (AppcastItemBase & Required<Pick<AppcastItemBase, "dsaSignature">>);

const emptyAppcastXML: AppcastXML = {
  rss: {
    '@version': '2.0',
    '@xmlns:sparkle': 'http://www.andymatuschak.org/xml-namespaces/sparkle',
    channel: {
      title: "",
      language: "en",
      item: [],
    },
  },
};

function itemToXml(item: AppcastItem): AppcastXMLItem {
  const xmlItem: AppcastXMLItem = {
    title: `Version ${item.version}`,
    'sparkle:version': item.version,
    pubDate: format(item.pubDate, "EEE, d LLL yyyy HH:mm:dd xx"),
    enclosure: {
      '@url': item.url,
      '@sparkle:os': item.os,
      '@length': item.length.toString(),
      '@type': 'application/octet-stream'
    }
  }
  if (item.description) {
    xmlItem.description = item.description;
  }
  if (item.releaseNotesLink) {
    xmlItem['sparkle:releaseNotesLink'] = item.releaseNotesLink;
  }
  if (item.minimumSystemVersion) {
    xmlItem['sparkle:minimumSystemVersion'] = item.minimumSystemVersion;
  }
  if (item.minimumAutoupdateVersion) {
    xmlItem['sparkle:minimumAutoupdateVersion'] = item.minimumAutoupdateVersion;
  }
  if (item.ignoreSkippedUpgradesBelowVersion) {
    xmlItem['sparkle:ignoreSkippedUpgradesBelowVersion'] = item.ignoreSkippedUpgradesBelowVersion;
  }
  if (item.edSignature) {
    xmlItem.enclosure['@sparkle:edSignature'] = item.edSignature;
  }
  if (item.dsaSignature) {
    xmlItem.enclosure['@sparkle:dsaSignature'] = item.dsaSignature;
  }
  return xmlItem;
}

export function createAppcastXml(options: {previous?: string; setting?: AppcastSetting; items: AppcastItem[]; mode: "add"}) {
  const { previous, setting, items, mode } = options;
  const xml = previous ? convert(previous, { format: "object" }) as AppcastXML : emptyAppcastXML;
  if (setting) {
    xml.rss.channel.title = setting.title;
    xml.rss.channel.language = setting.language;
    if (setting.description) {
      xml.rss.channel.description = setting.description;
    } else {
      delete xml.rss.channel.description;
    }
  }
  if (!Array.isArray(xml.rss.channel.item)) {
    xml.rss.channel.item = [xml.rss.channel.item];
  }
  if (mode === "add") {
    const indexByTitle = new Map(xml.rss.channel.item.map((item, index) => [item.enclosure["@url"], index]));
    for (const item of items) {
      const xmlItem = itemToXml(item);
      const index = indexByTitle.get(xmlItem.enclosure["@url"]);
      if (index != null) {
        xml.rss.channel.item[index] = xmlItem;
      } else {
        xml.rss.channel.item.push(xmlItem);
      }
    }
  }
  return convert(xml, { format: "xml" });
}
